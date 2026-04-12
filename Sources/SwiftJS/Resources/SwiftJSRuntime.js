(function () {
  const componentState = new Map()
  let mountedComponent = null
  let eventHandlers = Object.create(null)
  let pendingEffects = []
  let seenComponents = new Set()
  let activeComponentKey = null
  let activeHookIndex = 0
  let nextModuleCallID = 1
  const pendingModuleCalls = new Map()
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

  function invokeModule(moduleName, methodName, payload) {
    return new Promise(function (resolve, reject) {
      const callID = String(nextModuleCallID++)
      pendingModuleCalls.set(callID, { resolve: resolve, reject: reject })

      try {
        __swiftjs_invokeModule(
          callID,
          moduleName,
          methodName,
          payload === undefined ? undefined : JSON.stringify(payload)
        )
      } catch (error) {
        pendingModuleCalls.delete(callID)
        reject(error)
      }
    })
  }

  function resolveModuleCall(callID, payloadJSON) {
    const pendingCall = pendingModuleCalls.get(callID)
    if (!pendingCall) {
      return
    }

    pendingModuleCalls.delete(callID)
    pendingCall.resolve(payloadJSON === null || payloadJSON === undefined ? undefined : parseJSON(payloadJSON))
  }

  function rejectModuleCall(callID, message) {
    const pendingCall = pendingModuleCalls.get(callID)
    if (!pendingCall) {
      return
    }

    pendingModuleCalls.delete(callID)
    pendingCall.reject(new Error(message))
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
      case "ViewThatFits":
        node.axis = typeof props.axis === "string" ? props.axis : undefined
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
      case "Sheet":
        if (typeof props.isPresented !== "boolean") {
          throw new Error("Sheet requires an isPresented boolean prop")
        }

        node.isPresented = props.isPresented
        node.content = serializeSlot(props.content, path + ".content", "content")
        node.children = hostChildren(children)
        node.presentationDetents = serializePresentationDetents(props.presentationDetents)
        if (typeof props.presentationDragIndicator === "string") {
          node.presentationDragIndicator = props.presentationDragIndicator
        }
        if (typeof props.presentationCornerRadius === "number") {
          node.presentationCornerRadius = props.presentationCornerRadius
        }
        serializePresentationBackgroundInteraction(node, props.presentationBackgroundInteraction)
        node.interactiveDismissDisabled = props.interactiveDismissDisabled === true
        if (typeof props.onDismiss === "function") {
          node.onDismiss = registerHandler(props.onDismiss, id + ":dismiss")
        }
        return node
      case "FullScreenCover":
        if (typeof props.isPresented !== "boolean") {
          throw new Error("FullScreenCover requires an isPresented boolean prop")
        }

        node.isPresented = props.isPresented
        node.content = serializeSlot(props.content, path + ".content", "content")
        node.children = hostChildren(children)
        node.interactiveDismissDisabled = props.interactiveDismissDisabled === true
        if (typeof props.onDismiss === "function") {
          node.onDismiss = registerHandler(props.onDismiss, id + ":dismiss")
        }
        return node
      case "TabView":
        if (props.selection !== undefined) {
          node.selection = serializePickerValue(props.selection)
        }
        if (typeof props.onSelectionChange === "function") {
          node.event = registerHandler(props.onSelectionChange, id + ":selection")
        }
        node.children = hostChildren(children)
        return node
      case "Tab":
        if (typeof props.title !== "string" || props.title.length === 0) {
          throw new Error("Tab requires a title prop")
        }

        node.title = props.title
        if (typeof props.value === "string" || typeof props.value === "number") {
          node.selection = props.value
        }
        if (typeof props.systemName === "string") {
          node.systemName = props.systemName
        }
        if (typeof props.name === "string") {
          node.name = props.name
        }
        if (props.badge !== undefined) {
          node.badge = serializeBadgeValue(props.badge)
        }
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
      case "ContentUnavailableView":
        if (typeof props.title !== "string" || props.title.length === 0) {
          throw new Error("ContentUnavailableView requires a title prop")
        }

        node.title = props.title
        if (typeof props.systemName === "string") {
          node.systemName = props.systemName
        } else if (typeof props.name === "string") {
          node.name = props.name
        }
        node.description = serializeOptionalSlot(props.description, path + ".description")
        node.children = hostChildren(children)
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
      case "Rectangle":
      case "Circle":
      case "Capsule":
      case "Ellipse":
        node.fill = serializeShapeStyle(props.fill, path + ".fill")
        node.stroke = serializeShapeStyle(props.stroke, path + ".stroke")
        if (typeof props.lineWidth === "number") {
          node.lineWidth = props.lineWidth
        }
        return node
      case "RoundedRectangle":
        if (typeof props.cornerRadius !== "number") {
          throw new Error("RoundedRectangle requires a cornerRadius prop")
        }

        node.cornerRadius = props.cornerRadius
        node.fill = serializeShapeStyle(props.fill, path + ".fill")
        node.stroke = serializeShapeStyle(props.stroke, path + ".stroke")
        if (typeof props.lineWidth === "number") {
          node.lineWidth = props.lineWidth
        }
        return node
      case "LinearGradient":
        serializeGradient(node, type, props)
        return node
      case "RadialGradient":
        serializeGradient(node, type, props)
        if (typeof props.center === "string") {
          node.center = props.center
        }
        if (typeof props.startRadius === "number") {
          node.startRadius = props.startRadius
        }
        if (typeof props.endRadius === "number") {
          node.endRadius = props.endRadius
        } else {
          throw new Error("RadialGradient requires an endRadius prop")
        }
        return node
      case "AngularGradient":
        serializeGradient(node, type, props)
        if (typeof props.center === "string") {
          node.center = props.center
        }
        if (typeof props.angle === "number") {
          node.angle = props.angle
        }
        if (typeof props.startAngle === "number") {
          node.startAngle = props.startAngle
        }
        if (typeof props.endAngle === "number") {
          node.endAngle = props.endAngle
        }
        return node
      case "Divider":
        return node
      case "Button":
        node.title = textValue(props.children)
        node.children = hostChildren(children)
        node.event = registerHandler(props.action, id + ":action")
        return node
      case "Menu":
        node.title = textValue(props.children)
        node.children = hostChildren(children)
        node.content = serializeSlot(props.content, path + ".content", "content")
        return node
      case "DisclosureGroup":
        if (typeof props.isExpanded !== "boolean") {
          throw new Error("DisclosureGroup requires an isExpanded boolean prop")
        }

        node.title = textValue(props.children)
        node.children = hostChildren(children)
        node.content = serializeSlot(props.content, path + ".content", "content")
        node.isPresented = props.isExpanded
        node.event = registerHandler(props.onExpandedChange, id + ":expanded")
        return node
      case "ControlGroup":
        node.children = hostChildren(children)
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

    if (typeof props.foregroundColor === "string") {
      node.foregroundColor = props.foregroundColor
    }

    node.background = serializeShapeStyle(props.background, id + ".background")
    node.foregroundStyle = serializeShapeStyle(props.foregroundStyle, id + ".foregroundStyle")
    node.listRowBackground = serializeShapeStyle(props.listRowBackground, id + ".listRowBackground")

    if (typeof props.tint === "string") {
      node.tint = props.tint
    }

    if (typeof props.cornerRadius === "number") {
      node.cornerRadius = props.cornerRadius
    }

    if (typeof props.navigationTitle === "string") {
      node.navigationTitle = props.navigationTitle
    }

    if (typeof props.navigationBarTitleDisplayMode === "string") {
      node.navigationBarTitleDisplayMode = props.navigationBarTitleDisplayMode
    }

    if (typeof props.navigationLinkIndicatorVisibility === "string") {
      node.navigationLinkIndicatorVisibility = props.navigationLinkIndicatorVisibility
    }

    node.toolbarItems = serializeToolbarItems(props.toolbar, id + ".toolbar")

    if (typeof props.toolbarBackgroundVisibility === "string") {
      node.toolbarBackgroundVisibility = props.toolbarBackgroundVisibility
    }

    if (typeof props.toolbarColorScheme === "string") {
      node.toolbarColorScheme = props.toolbarColorScheme
    }

    if (typeof props.listStyle === "string") {
      node.listStyle = props.listStyle
    }

    if (typeof props.scrollContentBackground === "string") {
      node.scrollContentBackground = props.scrollContentBackground
    }

    if (typeof props.listRowSeparator === "string") {
      node.listRowSeparator = props.listRowSeparator
    }

    if (typeof props.listSectionSeparator === "string") {
      node.listSectionSeparator = props.listSectionSeparator
    }

    serializeEdgeInsets(node, props.listRowInsets)
    node.contentMargins = serializeContentMargins(props.contentMargins)

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

    serializeSafeAreaPadding(node, props.safeAreaPadding)
    serializeIgnoresSafeArea(node, props.ignoresSafeArea)
    node.safeAreaInsets = serializeSafeAreaInsets(props.safeAreaInset, id + ".safeAreaInset")

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
      node.glassVariant = "regular"
    } else if (props.glassEffect === "clear") {
      node.glassEffect = true
      node.glassVariant = "clear"
    } else if (props.glassEffect && typeof props.glassEffect === "object") {
      node.glassEffect = true
      node.glassVariant = typeof props.glassEffect.variant === "string" ? props.glassEffect.variant : "regular"

      if (typeof props.glassEffect.tint === "string") {
        node.glassTint = props.glassEffect.tint
      }
    }

    if (typeof props.lineLimit === "number") {
      node.lineLimit = props.lineLimit
    }

    if (typeof props.multilineTextAlignment === "string") {
      node.multilineTextAlignment = props.multilineTextAlignment
    }

    if (typeof props.truncationMode === "string") {
      node.truncationMode = props.truncationMode
    }

    if (typeof props.minimumScaleFactor === "number") {
      node.minimumScaleFactor = props.minimumScaleFactor
    }

    serializeAlert(node, props.alert, id + ".alert")
    serializeConfirmationDialog(node, props.confirmationDialog, id + ".confirmationDialog")

    return node
  }

  function serializeGradient(node, type, props) {
    node.type = type

    if (Array.isArray(props.colors)) {
      node.colors = props.colors.map(function (color) {
        if (typeof color !== "string") {
          throw new Error(type + " colors must be strings")
        }

        return color
      })
    }

    if (Array.isArray(props.stops)) {
      node.stops = props.stops.map(function (stop) {
        if (
          !stop ||
          typeof stop !== "object" ||
          typeof stop.color !== "string" ||
          typeof stop.location !== "number"
        ) {
          throw new Error(type + " stops must be { color, location } objects")
        }

        return { color: stop.color, location: stop.location }
      })
    }

    if (!node.colors && !node.stops) {
      throw new Error(type + " requires colors or stops")
    }

    if (type === "LinearGradient") {
      if (typeof props.startPoint !== "string" || typeof props.endPoint !== "string") {
        throw new Error("LinearGradient requires startPoint and endPoint props")
      }

      node.startPoint = props.startPoint
      node.endPoint = props.endPoint
    }
  }

  function serializeShapeStyle(value, path) {
    if (typeof value === "string") {
      return value
    }

    if (value === undefined || value === null) {
      return undefined
    }

    const resolved = resolveElement(normalizeStyleElement(value), path)
    if (!resolved || typeof resolved !== "object" || Array.isArray(resolved)) {
      throw new Error("Shape style values must be a color string or gradient component")
    }

    if (
      resolved.type !== "LinearGradient" &&
      resolved.type !== "RadialGradient" &&
      resolved.type !== "AngularGradient"
    ) {
      throw new Error("Only gradient components can be used as shape styles")
    }

    return resolved
  }

  function normalizeStyleElement(value) {
    if (
      value &&
      typeof value === "object" &&
      typeof value.type === "string" &&
      !("props" in value)
    ) {
      const props = Object.assign({}, value)
      delete props.type
      return { type: value.type, props: props }
    }

    return value
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

  function serializeBadgeValue(value) {
    if (typeof value === "string" || typeof value === "number") {
      return value
    }

    throw new Error("Tab badge must be a string or number")
  }

  function serializeToolbarItems(items, path) {
    if (items === undefined || items === null) {
      return undefined
    }

    if (!Array.isArray(items)) {
      throw new Error("toolbar must be an array of toolbar items")
    }

    return items.map(function (item, index) {
      if (!item || typeof item !== "object") {
        throw new Error("toolbar items must be objects")
      }

      return {
        placement: typeof item.placement === "string" ? item.placement : "automatic",
        content: serializeSlot(item.content, path + "." + index + ".content", "toolbar item content")
      }
    })
  }

  function serializeEdgeInsets(node, value) {
    if (!value || typeof value !== "object") {
      return
    }

    if (typeof value.top === "number") {
      node.listRowInsetTop = value.top
    }
    if (typeof value.leading === "number") {
      node.listRowInsetLeading = value.leading
    }
    if (typeof value.bottom === "number") {
      node.listRowInsetBottom = value.bottom
    }
    if (typeof value.trailing === "number") {
      node.listRowInsetTrailing = value.trailing
    }
  }

  function serializeContentMargins(value) {
    if (value === undefined || value === null) {
      return undefined
    }

    const margins = Array.isArray(value) ? value : [value]
    return margins.map(function (entry) {
      if (!entry || typeof entry !== "object" || typeof entry.amount !== "number") {
        throw new Error("contentMargins entries must be { amount, edges?, placement? } objects")
      }

      return {
        edges: typeof entry.edges === "string" ? entry.edges : "all",
        amount: entry.amount,
        placement: typeof entry.placement === "string" ? entry.placement : "automatic"
      }
    })
  }

  function serializeSafeAreaPadding(node, value) {
    if (typeof value === "number") {
      node.safeAreaPaddingLength = value
      node.safeAreaPaddingEdges = "all"
      return
    }

    if (!value || typeof value !== "object") {
      return
    }

    if (typeof value.length !== "number") {
      throw new Error("safeAreaPadding object form requires a length")
    }

    node.safeAreaPaddingLength = value.length
    node.safeAreaPaddingEdges = typeof value.edges === "string" ? value.edges : "all"
  }

  function serializeIgnoresSafeArea(node, value) {
    if (value === true) {
      node.ignoresSafeArea = true
      node.ignoresSafeAreaEdges = "all"
      return
    }

    if (!value || typeof value !== "object") {
      return
    }

    node.ignoresSafeArea = true
    node.ignoresSafeAreaEdges = typeof value.edges === "string" ? value.edges : "all"
  }

  function serializeSafeAreaInsets(value, path) {
    if (value === undefined || value === null) {
      return undefined
    }

    const insets = Array.isArray(value) ? value : [value]
    return insets.map(function (entry, index) {
      if (!entry || typeof entry !== "object" || typeof entry.edge !== "string") {
        throw new Error("safeAreaInset entries must be { edge, spacing?, content } objects")
      }

      return {
        edge: entry.edge,
        spacing: typeof entry.spacing === "number" ? entry.spacing : undefined,
        content: serializeSlot(entry.content, path + "." + index + ".content", "safe area inset content")
      }
    })
  }

  function serializeAlert(node, value, path) {
    if (value === undefined || value === null) {
      return
    }

    if (!value || typeof value !== "object" || typeof value.title !== "string" || typeof value.isPresented !== "boolean") {
      throw new Error("alert must be { title, isPresented, message?, actions? }")
    }

    node.alertTitle = value.title
    node.alertIsPresented = value.isPresented
    node.alertMessage = serializeOptionalSlot(value.message, path + ".message")
    node.alertActions = serializeDialogActions(value.actions, path + ".actions")
  }

  function serializeConfirmationDialog(node, value, path) {
    if (value === undefined || value === null) {
      return
    }

    if (!value || typeof value !== "object" || typeof value.title !== "string" || typeof value.isPresented !== "boolean") {
      throw new Error("confirmationDialog must be { title, isPresented, message?, actions? }")
    }

    node.confirmationDialogTitle = value.title
    node.confirmationDialogIsPresented = value.isPresented
    node.confirmationDialogTitleVisibility =
      typeof value.titleVisibility === "string" ? value.titleVisibility : "automatic"
    node.confirmationDialogMessage = serializeOptionalSlot(value.message, path + ".message")
    node.confirmationDialogActions = serializeDialogActions(value.actions, path + ".actions")
  }

  function serializeDialogActions(actions, path) {
    if (actions === undefined || actions === null) {
      return undefined
    }

    if (!Array.isArray(actions)) {
      throw new Error("dialog actions must be an array")
    }

    return actions.map(function (action, index) {
      if (!action || typeof action !== "object" || typeof action.title !== "string") {
        throw new Error("dialog actions must be { title, role?, action? } objects")
      }

      return {
        title: action.title,
        role: typeof action.role === "string" ? action.role : undefined,
        event:
          typeof action.action === "function"
            ? registerHandler(action.action, path + "." + index + ".action")
            : undefined
      }
    })
  }

  function serializePresentationDetents(value) {
    if (value === undefined || value === null) {
      return undefined
    }

    if (!Array.isArray(value)) {
      throw new Error("presentationDetents must be an array")
    }

    return value.map(function (detent) {
      if (detent === "medium" || detent === "large") {
        return { kind: detent }
      }

      if (detent && typeof detent === "object" && typeof detent.fraction === "number") {
        return { kind: "fraction", value: detent.fraction }
      }

      if (detent && typeof detent === "object" && typeof detent.height === "number") {
        return { kind: "height", value: detent.height }
      }

      throw new Error("presentationDetents entries must be medium, large, { fraction }, or { height }")
    })
  }

  function serializePresentationBackgroundInteraction(node, value) {
    if (value === undefined || value === null) {
      return
    }

    if (typeof value === "string") {
      node.presentationBackgroundInteractionKind = value
      return
    }

    if (value && typeof value === "object" && value.upThrough !== undefined) {
      const detents = serializePresentationDetents([value.upThrough])
      node.presentationBackgroundInteractionKind = "upThrough"
      node.presentationBackgroundInteractionDetent = detents[0]
      return
    }

    throw new Error(
      "presentationBackgroundInteraction must be automatic, enabled, disabled, or { upThrough }"
    )
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
    if (value === undefined || value === null) {
      throw new Error("Missing " + name)
    }

    const resolved = resolveElement(value, path)
    const nodes = normalizeResolvedNodes(resolved, path)

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

    throw new Error("Missing " + name)
  }

  function serializeOptionalSlot(value, path) {
    if (value === undefined || value === null) {
      return undefined
    }

    return serializeSlot(value, path, "slot")
  }

  function normalizeResolvedNodes(resolved, path) {
    if (resolved && typeof resolved === "object" && !Array.isArray(resolved)) {
      return [resolved]
    }

    if (typeof resolved === "string" || typeof resolved === "number") {
      return [makeTextNode(String(resolved), path)]
    }

    if (Array.isArray(resolved)) {
      return flatten(
        resolved.map(function (child, index) {
          return normalizeResolvedNodes(child, path + "." + index)
        })
      ).filter(function (child) {
        return typeof child === "object" && child !== null
      })
    }

    return []
  }

  function makeTextNode(value, path) {
    return {
      type: "Text",
      id: autoID(path),
      value: value
    }
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
    invokeModule: invokeModule,
    rejectModuleCall: rejectModuleCall,
    resolveModuleCall: resolveModuleCall,
    useAppStorage: useAppStorage,
    useEffect: useEffect,
    useRef: useRef,
    useState: useState
  }
})()
