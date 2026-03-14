(function () {
  const componentState = new Map()
  let mountedComponent = null
  let eventHandlers = Object.create(null)
  let pendingEffects = []
  let seenComponents = new Set()
  let activeComponentKey = null
  let activeHookIndex = 0

  function createElement(type, props) {
    const extraChildren = Array.prototype.slice.call(arguments, 2)
    const normalizedProps = Object.assign({}, props || {})
    normalizedProps.children = flatten([normalizedProps.children, extraChildren]).filter(function (child) {
      return child !== undefined && child !== null && child !== false
    })
    return { type: type, props: normalizedProps }
  }

  function useState(initialValue) {
    const slot = currentHookSlot("useState")
    if (!("value" in slot)) {
      slot.value = typeof initialValue === "function" ? initialValue() : initialValue
    }

    function setState(nextValue) {
      slot.value = typeof nextValue === "function" ? nextValue(slot.value) : nextValue
      render()
    }

    return [slot.value, setState]
  }

  function useRef(initialValue) {
    const slot = currentHookSlot("useRef")
    if (!("value" in slot)) {
      slot.value = { current: initialValue }
    }

    return slot.value
  }

  function useEffect(effect, deps) {
    const slot = currentHookSlot("useEffect")
    const normalizedDeps = Array.isArray(deps) ? deps.slice() : null
    const shouldRun =
      normalizedDeps === null ||
      !Array.isArray(slot.deps) ||
      slot.deps.length !== normalizedDeps.length ||
      normalizedDeps.some(function (value, index) {
        return !Object.is(value, slot.deps[index])
      })

    if (shouldRun) {
      pendingEffects.push(function () {
        if (typeof slot.cleanup === "function") {
          slot.cleanup()
        }

        const cleanup = effect()
        slot.cleanup = typeof cleanup === "function" ? cleanup : null
        slot.deps = normalizedDeps
      })
    }
  }

  function mount(component) {
    mountedComponent = component
    render()
  }

  function dispatchEvent(eventId) {
    const handler = eventHandlers[eventId]
    if (typeof handler !== "function") {
      throw new Error("Missing event handler for " + eventId)
    }

    handler()
  }

  function render() {
    if (typeof mountedComponent !== "function") {
      throw new Error("swiftjs mount() expects a root component")
    }

    eventHandlers = Object.create(null)
    pendingEffects = []
    seenComponents = new Set()

    const tree = resolveElement(createElement(mountedComponent, null), "0")
    cleanupUnmountedComponents()
    __swiftjs_commit(JSON.stringify(tree))
    flushEffects()
  }

  function resolveElement(element, path) {
    if (element === null || element === undefined || element === false || element === true) {
      return null
    }

    if (Array.isArray(element)) {
      return flatten(
        element.map(function (child, index) {
          return resolveElement(child, path + "." + index)
        })
      ).filter(function (child) {
        return child !== null
      })
    }

    if (typeof element === "string" || typeof element === "number") {
      return String(element)
    }

    if (typeof element.type === "function") {
      const previousKey = activeComponentKey
      const previousHookIndex = activeHookIndex
      activeComponentKey = path
      activeHookIndex = 0
      seenComponents.add(path)
      const result = resolveElement(element.type(element.props || {}), path)
      activeComponentKey = previousKey
      activeHookIndex = previousHookIndex
      return result
    }

    return renderHostComponent(element.type, element.props || {}, path)
  }

  function renderHostComponent(type, props, path) {
    if (type === Fragment) {
      return resolveElement(props.children || [], path)
    }

    const children = flatten(
      flatten(props.children || []).map(function (child, index) {
        return resolveElement(child, path + "." + index)
      })
    ).filter(function (child) {
      return child !== null
    })

    const id = typeof props.id === "string" ? props.id : autoID(path)
    const node = serializeBaseNode(type, id, props)

    switch (type) {
      case "VStack":
        node.spacing = numericProp(props.spacing, 16)
        node.children = hostChildren(children)
        return node
      case "HStack":
        node.spacing = numericProp(props.spacing, 12)
        node.children = hostChildren(children)
        return node
      case "Text":
        node.value = textValue(props.children)
        return node
      case "Image":
        if (typeof props.systemName === "string") {
          node.systemName = props.systemName
          return node
        }

        if (typeof props.name === "string") {
          node.name = props.name
          return node
        }

        throw new Error("Image requires a systemName or name prop")
      case "Divider":
        return node
      case "Button":
        node.title = textValue(props.children)
        node.event = registerHandler(props.action, id + ":action")
        return node
      default:
        throw new Error("Unsupported host component: " + type)
    }
  }

  function serializeBaseNode(type, id, props) {
    const node = {
      type: type,
      id: id
    }

    if (typeof props.padding === "number") {
      node.padding = props.padding
    }

    if (typeof props.paddingTop === "number") {
      node.paddingTop = props.paddingTop
    }

    if (props.frame && typeof props.frame.width === "number") {
      node.frameWidth = props.frame.width
    }

    if (props.frame && typeof props.frame.height === "number") {
      node.frameHeight = props.frame.height
    }

    if (typeof props.background === "string") {
      node.background = props.background
    }

    if (typeof props.foregroundColor === "string") {
      node.foregroundColor = props.foregroundColor
    }

    if (typeof props.cornerRadius === "number") {
      node.cornerRadius = props.cornerRadius
    }

    if (typeof props.onAppear === "function") {
      node.onAppearEvent = registerHandler(props.onAppear, id + ":onAppear")
    }

    const font = normalizeFont(props.font)
    if (font.fontName) {
      node.fontName = font.fontName
    }
    if (typeof font.fontSize === "number") {
      node.fontSize = font.fontSize
    }
    if (font.fontWeight) {
      node.fontWeight = font.fontWeight
    }

    if (typeof props.fontWeight === "string") {
      node.fontWeight = props.fontWeight
    }

    if (typeof props.symbolRenderingMode === "string") {
      node.symbolRenderingMode = props.symbolRenderingMode
    }

    if (typeof props.buttonStyle === "string") {
      node.buttonStyle = props.buttonStyle
    }

    if (typeof props.buttonBorderShape === "string") {
      node.buttonBorderShape = props.buttonBorderShape
    }

    if (props.disabled === true) {
      node.isDisabled = true
    }

    if (props.glassEffect === true) {
      node.glassEffect = true
    } else if (props.glassEffect && typeof props.glassEffect === "object") {
      node.glassEffect = true

      if (typeof props.glassEffect.tint === "string") {
        node.glassTint = props.glassEffect.tint
      }
    }

    return node
  }

  function normalizeFont(font) {
    if (typeof font === "string") {
      return { fontName: font }
    }

    if (font && font.system && typeof font.system.size === "number") {
      return {
        fontSize: font.system.size,
        fontWeight: typeof font.system.weight === "string" ? font.system.weight : undefined
      }
    }

    return {}
  }

  function currentHookSlot(name) {
    if (activeComponentKey === null) {
      throw new Error(name + " can only be used inside a component")
    }

    const component = componentRecord(activeComponentKey)
    const slotIndex = activeHookIndex
    activeHookIndex += 1
    component.hooks[slotIndex] = component.hooks[slotIndex] || {}
    return component.hooks[slotIndex]
  }

  function componentRecord(key) {
    if (!componentState.has(key)) {
      componentState.set(key, { hooks: [] })
    }

    return componentState.get(key)
  }

  function cleanupUnmountedComponents() {
    componentState.forEach(function (record, key) {
      if (seenComponents.has(key)) {
        return
      }

      record.hooks.forEach(function (slot) {
        if (slot && typeof slot.cleanup === "function") {
          slot.cleanup()
        }
      })

      componentState.delete(key)
    })
  }

  function flushEffects() {
    const effects = pendingEffects.slice()
    pendingEffects = []
    effects.forEach(function (effect) {
      effect()
    })
  }

  function registerHandler(handler, stableID) {
    if (typeof handler !== "function") {
      throw new Error("Missing function handler for " + stableID)
    }

    eventHandlers[stableID] = handler
    return stableID
  }

  function hostChildren(children) {
    return children.filter(function (child) {
      return typeof child === "object" && child !== null
    })
  }

  function textValue(children) {
    return flatten(children)
      .filter(function (child) {
        return typeof child === "string" || typeof child === "number"
      })
      .map(function (child) {
        return String(child)
      })
      .join("")
  }

  function flatten(items) {
    const result = []
    items.forEach(function (item) {
      if (Array.isArray(item)) {
        result.push.apply(result, flatten(item))
      } else if (item !== undefined) {
        result.push(item)
      }
    })
    return result
  }

  function numericProp(value, fallback) {
    return typeof value === "number" ? value : fallback
  }

  function autoID(path) {
    return "node_" + path.replace(/\./g, "_")
  }

  const Fragment = Symbol("SwiftJS.Fragment")

  globalThis.__swiftjsRuntime = {
    Fragment: Fragment,
    createElement: createElement,
    dispatchEvent: dispatchEvent,
    mount: mount,
    useEffect: useEffect,
    useRef: useRef,
    useState: useState
  }
})()
