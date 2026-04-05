(function () {
  const componentState = new Map()
  let mountedComponent = null
  let eventHandlers = Object.create(null)
  let pendingEffects = []
  let seenComponents = new Set()
  let activeComponentKey = null
  let activeHookIndex = 0
  let layoutHandlers = Object.create(null)
  let geometryReaderHandlers = Object.create(null)

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

  function useAppStorage(key, defaultValue) {
    if (typeof key !== "string" || key.length === 0) {
      throw new Error("useAppStorage requires a non-empty string key")
    }

    assertAppStorageValue(defaultValue)

    const [value, setValue] = useState(function () {
      const stored = __swiftjs_storage_get(key)
      if (typeof stored !== "string" || stored.length === 0) {
        return defaultValue
      }

      const parsed = parseJSON(stored)
      assertAppStorageValue(parsed)
      return parsed
    })

    function setStoredValue(nextValue) {
      setValue(function (currentValue) {
        const resolved = typeof nextValue === "function" ? nextValue(currentValue) : nextValue
        assertAppStorageValue(resolved)
        __swiftjs_storage_set(key, JSON.stringify(resolved))
        return resolved
      })
    }

    return [value, setStoredValue]
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

  function dispatchEvent(eventId, payloadJSON) {
    const handler = eventHandlers[eventId]
    if (typeof handler !== "function") {
      throw new Error("Missing event handler for " + eventId)
    }

    handler(parseJSON(payloadJSON))
  }

  function render() {
    if (typeof mountedComponent !== "function") {
      throw new Error("swiftjs mount() expects a root component")
    }

    eventHandlers = Object.create(null)
    layoutHandlers = Object.create(null)
    geometryReaderHandlers = Object.create(null)
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
        if (typeof child === "function") {
          return child
        }

        return resolveElement(child, path + "." + index)
      })
    ).filter(function (child) {
      return child !== null
    })

    const id = typeof props.id === "string" ? props.id : autoID(path)
    const node = serializeBaseNode(type, id, props)

    switch (type) {
      case "VStack":
      case "HStack":
        node.alignment = typeof props.alignment === "string" ? props.alignment : "center"
        node.distribution = typeof props.distribution === "string" ? props.distribution : "natural"
        node.spacing = numericProp(props.spacing, type === "VStack" ? 16 : 12)
        node.children = hostChildren(children)
        return node
      case "Grid":
        node.horizontalSpacing = numericProp(props.horizontalSpacing, 12)
        node.verticalSpacing = numericProp(props.verticalSpacing, 12)
        node.children = hostChildren(children)
        return node
      case "FlowLayout":
        node.alignment = typeof props.alignment === "string" ? props.alignment : "center"
        node.spacing = numericProp(props.spacing, 8)
        node.lineSpacing = numericProp(props.lineSpacing, numericProp(props.spacing, 8))
        node.children = hostChildren(children)
        return node
      case "GridRow":
        node.alignment = typeof props.alignment === "string" ? props.alignment : "center"
        node.children = hostChildren(children)
        return node
      case "ZStack":
        node.alignment = typeof props.alignment === "string" ? props.alignment : "center"
        node.children = hostChildren(children)
        return node
      case "ScrollView":
        node.axis = typeof props.axis === "string" ? props.axis : "vertical"
        node.children = hostChildren(children)
        return node
      case "GeometryReader": {
        const content = Array.isArray(props.children)
          ? props.children.find(function (child) {
              return typeof child === "function"
            })
          : typeof props.children === "function"
            ? props.children
            : undefined

        if (typeof content !== "function") {
          throw new Error("GeometryReader requires a render function child")
        }

        geometryReaderHandlers[id] = content
        return node
      }
      case "Custom":
        if (typeof props.name !== "string" || props.name.length === 0) {
          throw new Error("Custom requires a name prop")
        }

        node.customName = props.name
        node.children = hostChildren(children)
        node.customValues = serializeCustomValues(props.values)
        node.customSlots = serializeCustomSlots(props.slots, path)
        return node
      case "CustomLayout":
        if (typeof props.name !== "string" || props.name.length === 0) {
          throw new Error("CustomLayout requires a name prop")
        }

        if (typeof props.sizeThatFits === "function" && typeof props.placeSubviews === "function") {
          layoutHandlers[id] = {
            sizeThatFits: props.sizeThatFits,
            placeSubviews: props.placeSubviews
          }
        }

        node.customName = props.name
        node.children = hostChildren(children)
        node.customValues = serializeCustomValues(props.values)
        return node
      case "List":
        node.children = hostChildren(children)
        return node
      case "Form":
        node.children = hostChildren(children)
        return node
      case "Section":
        node.title = typeof props.title === "string" ? props.title : undefined
        node.children = hostChildren(children)
        return node
      case "NavigationStack":
        node.children = hostChildren(children)
        return node
      case "NavigationLink":
        node.destination = serializeSlot(props.destination, path + ".destination", "destination")
        node.children = hostChildren(children)
        return node
      case "NavigationSplitView":
        node.sidebar = serializeSlot(props.sidebar, path + ".sidebar", "sidebar")
        node.detail = serializeSlot(props.detail, path + ".detail", "detail")
        return node
      case "Spacer":
        return node
      case "Text":
        node.value = textValue(props.children)
        return node
      case "Label":
        if (typeof props.title !== "string") {
          throw new Error("Label requires a title prop")
        }

        node.title = props.title

        if (typeof props.systemName === "string") {
          node.systemName = props.systemName
          return node
        }

        if (typeof props.name === "string") {
          node.name = props.name
          return node
        }

        throw new Error("Label requires a systemName or name prop")
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
        node.children = hostChildren(children)
        node.event = registerHandler(props.action, id + ":action")
        return node
      case "Picker":
        node.title = textValue(props.children)
        node.children = hostChildren(children)
        node.selection = serializePickerValue(props.selection)
        node.options = serializePickerOptions(props.options)
        node.event = registerHandler(props.onChange, id + ":change")
        return node
      case "Toggle":
        if (typeof props.isOn !== "boolean") {
          throw new Error("Toggle requires an isOn boolean prop")
        }

        node.title = textValue(props.children)
        node.children = hostChildren(children)
        node.isOn = props.isOn
        node.event = registerHandler(props.onChange, id + ":change")
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

    if (typeof props.alignment === "string") {
      node.alignment = props.alignment
    }

    if (
      typeof props.viewID === "string" ||
      typeof props.viewID === "number" ||
      typeof props.viewID === "boolean"
    ) {
      node.viewIdentity = serializeCustomValue(props.viewID)
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

    if (props.frame && typeof props.frame.minWidth === "number") {
      node.frameMinWidth = props.frame.minWidth
    }

    if (props.frame && typeof props.frame.minHeight === "number") {
      node.frameMinHeight = props.frame.minHeight
    }

    if (props.frame && typeof props.frame.maxWidth === "number") {
      node.frameMaxWidthValue = props.frame.maxWidth
    } else if (props.frame && props.frame.maxWidth === "infinity") {
      node.frameMaxWidth = true
    }

    if (props.frame && typeof props.frame.maxHeight === "number") {
      node.frameMaxHeightValue = props.frame.maxHeight
    } else if (props.frame && props.frame.maxHeight === "infinity") {
      node.frameMaxHeight = true
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

    if (typeof props.navigationTitle === "string") {
      node.navigationTitle = props.navigationTitle
    }

    if (typeof props.navigationLinkIndicatorVisibility === "string") {
      node.navigationLinkIndicatorVisibility = props.navigationLinkIndicatorVisibility
    }

    if (typeof props.listStyle === "string") {
      node.listStyle = props.listStyle
    }

    if (typeof props.imageContentMode === "string") {
      node.imageContentMode = props.imageContentMode
    }

    if (typeof props.interpolation === "string") {
      node.imageInterpolation = props.interpolation
    }

    if (typeof props.aspectRatio === "number") {
      node.aspectRatio = props.aspectRatio
      node.aspectRatioContentMode = "fit"
    } else if (props.aspectRatio && typeof props.aspectRatio === "object") {
      if (typeof props.aspectRatio.value === "number") {
        node.aspectRatio = props.aspectRatio.value
      }

      if (typeof props.aspectRatio.contentMode === "string") {
        node.aspectRatioContentMode = props.aspectRatio.contentMode
      } else if ("value" in props.aspectRatio) {
        node.aspectRatioContentMode = "fit"
      }
    }

    if (props.fixedSize === true) {
      node.fixedSizeHorizontal = true
      node.fixedSizeVertical = true
    } else if (props.fixedSize && typeof props.fixedSize === "object") {
      if (props.fixedSize.horizontal === true) {
        node.fixedSizeHorizontal = true
      }

      if (props.fixedSize.vertical === true) {
        node.fixedSizeVertical = true
      }
    }

    if (props.compactVertical === true) {
      node.compactVertical = true
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

  function serializeCustomValues(values) {
    if (!values || typeof values !== "object") {
      return undefined
    }

    const result = {}

    Object.keys(values).forEach(function (key) {
      result[key] = serializeCustomValue(values[key])
    })

    return Object.keys(result).length > 0 ? result : undefined
  }

  function serializeCustomValue(value) {
    if (typeof value === "string" || typeof value === "number" || typeof value === "boolean") {
      return value
    }

    if (Array.isArray(value)) {
      return value.map(function (item) {
        return serializeCustomValue(item)
      })
    }

    if (value && typeof value === "object") {
      const result = {}

      Object.keys(value).forEach(function (key) {
        result[key] = serializeCustomValue(value[key])
      })

      return result
    }

    throw new Error("Custom values must be JSON-compatible")
  }

  function serializeCustomSlots(slots, path) {
    if (!slots || typeof slots !== "object") {
      return undefined
    }

    const result = {}

    Object.keys(slots).forEach(function (key) {
      result[key] = serializeSlot(slots[key], path + "." + key, key)
    })

    return result
  }

  function serializePickerValue(value) {
    if (typeof value === "string" || typeof value === "number") {
      return value
    }

    throw new Error("Picker selection must be a string or number")
  }

  function serializePickerOptions(options) {
    if (!Array.isArray(options)) {
      throw new Error("Picker requires an options array")
    }

    return options.map(function (option) {
      if (typeof option === "string" || typeof option === "number") {
        return {
          title: String(option),
          value: option
        }
      }

      if (
        option &&
        typeof option === "object" &&
        typeof option.title === "string" &&
        (typeof option.value === "string" || typeof option.value === "number")
      ) {
        return {
          title: option.title,
          value: option.value
        }
      }

      throw new Error("Picker options must be strings, numbers, or { title, value } objects")
    })
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

  function serializeSlot(value, path, name) {
    const resolved = resolveElement(value, path)

    if (resolved && typeof resolved === "object" && !Array.isArray(resolved)) {
      return resolved
    }

    if (Array.isArray(resolved)) {
      const nodes = resolved.filter(function (child) {
        return typeof child === "object" && child !== null
      })

      if (nodes.length === 1) {
        return nodes[0]
      }

      if (nodes.length > 1) {
        return {
          type: "VStack",
          id: autoID(path),
          alignment: "leading",
          spacing: 0,
          children: nodes
        }
      }
    }

    throw new Error("NavigationSplitView requires a " + name + " slot")
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

  function hasLayoutHandler(id) {
    return !!layoutHandlers[id]
  }

  function hasGeometryReaderHandler(id) {
    return !!geometryReaderHandlers[id]
  }

  function measureLayout(id, proposalJSON, subviewCount) {
    const handler = layoutHandlers[id]
    if (!handler) {
      throw new Error("Missing custom layout handler: " + id)
    }

    const proposal = createProposedViewSize(parseJSON(proposalJSON))
    const subviews = createLayoutSubviews(subviewCount)
    return JSON.stringify(normalizeSize(handler.sizeThatFits(proposal, subviews)))
  }

  function placeLayoutSubviews(id, boundsJSON, proposalJSON, subviewCount) {
    const handler = layoutHandlers[id]
    if (!handler) {
      throw new Error("Missing custom layout handler: " + id)
    }

    const bounds = createBounds(parseJSON(boundsJSON))
    const proposal = createProposedViewSize(parseJSON(proposalJSON))
    const subviews = createLayoutSubviews(subviewCount)
    return JSON.stringify(handler.placeSubviews(bounds, proposal, subviews) || [])
  }

  function renderGeometryReader(id, sizeJSON) {
    const handler = geometryReaderHandlers[id]
    if (!handler) {
      throw new Error("Missing GeometryReader handler: " + id)
    }

    const size = normalizeSize(parseJSON(sizeJSON))
    const content = handler({
      size: {
        width: typeof size.width === "number" ? size.width : 0,
        height: typeof size.height === "number" ? size.height : 0
      }
    })
    const resolved = resolveElement(content, "geometry." + id)
    return JSON.stringify(serializeGeometryReaderContent(resolved, "geometry." + id))
  }

  function createLayoutSubviews(subviewCount) {
    const result = []

    for (let index = 0; index < subviewCount; index += 1) {
      result.push({
        sizeThatFits: function (proposal) {
          return parseJSON(__swiftjs_layout_subviewSizeThatFits(index, JSON.stringify(normalizeSize(proposal))))
        }
      })
    }

    return result
  }

  function serializeGeometryReaderContent(resolved, path) {
    if (resolved && typeof resolved === "object" && !Array.isArray(resolved)) {
      return resolved
    }

    if (Array.isArray(resolved)) {
      const nodes = resolved.filter(function (child) {
        return typeof child === "object" && child !== null
      })

      if (nodes.length === 1) {
        return nodes[0]
      }

      if (nodes.length > 1) {
        return {
          type: "VStack",
          id: autoID(path),
          alignment: "leading",
          spacing: 0,
          children: nodes
        }
      }
    }

    throw new Error("GeometryReader requires view content")
  }

  function createProposedViewSize(value) {
    const size = normalizeSize(value)
    size.replacingUnspecifiedDimensions = function (replacement) {
      return {
        width: size.width === undefined ? replacement.width : size.width,
        height: size.height === undefined ? replacement.height : size.height
      }
    }
    return size
  }

  function createBounds(value) {
    return {
      minX: typeof value.minX === "number" ? value.minX : 0,
      minY: typeof value.minY === "number" ? value.minY : 0,
      width: typeof value.width === "number" ? value.width : 0,
      height: typeof value.height === "number" ? value.height : 0
    }
  }

  function normalizeSize(value) {
    if (!value || typeof value !== "object") {
      return {}
    }

    return {
      width: typeof value.width === "number" ? value.width : undefined,
      height: typeof value.height === "number" ? value.height : undefined
    }
  }

  function parseJSON(value) {
    if (typeof value !== "string" || value.length === 0) {
      return null
    }

    return JSON.parse(value)
  }

  function assertAppStorageValue(value) {
    if (typeof value === "string" || typeof value === "number" || typeof value === "boolean") {
      return
    }

    throw new Error("useAppStorage only supports string, number, and boolean values")
  }

  const Fragment = Symbol("SwiftJS.Fragment")

  globalThis.__swiftjsRuntime = {
    Fragment: Fragment,
    createElement: createElement,
    dispatchEvent: dispatchEvent,
    hasGeometryReaderHandler: hasGeometryReaderHandler,
    hasLayoutHandler: hasLayoutHandler,
    measureLayout: measureLayout,
    mount: mount,
    placeLayoutSubviews: placeLayoutSubviews,
    renderGeometryReader: renderGeometryReader,
    useAppStorage: useAppStorage,
    useEffect: useEffect,
    useRef: useRef,
    useState: useState
  }
})()
