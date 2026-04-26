/**
 * Shared value and prop types for the SwiftJS TSX surface.
 *
 * const frame: FrameValue = { maxWidth: "infinity", minHeight: 160 }
 * const detents: PresentationDetentValue[] = ["medium", { height: 220 }]
 */
/** Named colors SwiftJS resolves directly. */
export type NamedColorValue =
  | "red"
  | "green"
  | "yellow"
  | "blue"
  | "orange"
  | "pink"
  | "purple"
  | "cyan"
  | "gray"
  | "grey"
  | "black"
  | "mint"
  | "indigo"
  | "teal"
  | "white"
  | "primary"
  | "secondary"
  | "tint"
  | "clear"
  | "systemBackground"
  | "systemGroupedBackground"
  | "secondarySystemBackground"
  | "tertiarySystemBackground"
  | "tertiarySystemFill"
  | "quaternarySystemFill"

/** `#RGB`, `#RGBA`, `#RRGGBB`, or `#RRGGBBAA`. */
export type HexColorValue = `#${string}`

/** Named colors, `#` hex colors, or custom strings passed through to `SwiftUI.Color`. */
export type ColorValue = NamedColorValue | HexColorValue | (string & {})

/** Mirrors `SwiftUI.Font.Weight`. */
export type FontWeight =
  | "ultraLight"
  | "thin"
  | "light"
  | "regular"
  | "medium"
  | "semibold"
  | "bold"
  | "heavy"
  | "black"

/** Mirrors `SwiftUI.SymbolRenderingMode`. */
export type SymbolRenderingMode = "monochrome" | "hierarchical" | "multicolor"

/** Mirrors the button styles SwiftJS maps to `SwiftUI.ButtonStyle`. */
export type ButtonStyle =
  | "automatic"
  | "plain"
  | "borderless"
  | "bordered"
  | "borderedProminent"
  | "glass"
  | "glassProminent"

/** Mirrors `SwiftUI.ButtonBorderShape`. */
export type ButtonBorderShape = "automatic" | "capsule" | "roundedRectangle" | "circle"

/** Mirrors `SwiftUI.ButtonSizing`. */
export type ButtonSizing = "automatic" | "flexible"

/** Mirrors the common hit-test and glass shapes used by SwiftUI. */
export type ShapeValue =
  | "rectangle"
  | "circle"
  | "capsule"
  | { rect: { cornerRadius?: number } }
  | { roundedRectangle: { cornerRadius: number } }

/** Mirrors the common hit-test shapes used with `.contentShape(...)`. */
export type ContentShapeValue = ShapeValue

/** Mirrors `SwiftUI.ScrollEdgeEffectStyle`. */
export type ScrollEdgeEffectStyleValue = "automatic" | "hard" | "soft"

/** Mirrors `.scrollEdgeEffectStyle(_:for:)`. */
export type ScrollEdgeEffectValue =
  | ScrollEdgeEffectStyleValue
  | {
      style: ScrollEdgeEffectStyleValue
      edge?: EdgeValue
    }

/** Mirrors the liquid glass variants SwiftJS supports. */
export type GlassEffectValue =
  | boolean
  | "clear"
  | {
      variant?: "regular" | "clear"
      tint?: ColorValue
      shape?: ShapeValue
      interactive?: boolean
      id?: string
      unionID?: string
    }

/** Shared alignment values used by stacks, frames, and shape anchors. */
export type ContentAlignment =
  | "leading"
  | "center"
  | "trailing"
  | "top"
  | "bottom"
  | "topLeading"
  | "topTrailing"
  | "bottomLeading"
  | "bottomTrailing"

/** Mirrors `TextAlignment`. */
export type TextAlignmentValue = "leading" | "center" | "trailing"

/** Mirrors `Text.TruncationMode`. */
export type TruncationMode = "head" | "middle" | "tail"

/** Mirrors the common `UnitPoint` cases SwiftJS supports. */
export type UnitPointValue = ContentAlignment

/** Mirrors `SwiftUI.Axis`. */
export type AxisValue = "vertical" | "horizontal"

/** Mirrors `SwiftUI.Edge`. */
export type EdgeValue = "top" | "bottom" | "leading" | "trailing"

/** Mirrors `HorizontalEdge`. */
export type HorizontalEdgeValue = "leading" | "trailing"

/** Mirrors `Edge.Set`. */
export type EdgeSetValue = EdgeValue | "horizontal" | "vertical" | "all"

/** Shared distribution values for stack layouts. */
export type StackDistribution = "natural" | "fillEqually"

/** Mirrors the list styles SwiftJS maps to SwiftUI. */
export type ListStyle = "automatic" | "plain" | "grouped" | "inset" | "insetGrouped" | "sidebar"

/** Mirrors SwiftUI image content modes. */
export type ImageContentMode = "fit" | "fill"

/** Mirrors the image interpolation values SwiftJS supports. */
export type ImageInterpolation = "none" | "low" | "medium" | "high"

/** Mirrors SwiftUI.Visibility for navigation and presentation chrome. */
export type VisibilityKind = "automatic" | "visible" | "hidden"

/** Backwards-compatible alias for `VisibilityKind`. */
export type Visibility = VisibilityKind

/** Mirrors `NavigationBarItem.TitleDisplayMode`. */
export type NavigationBarTitleDisplayMode = "automatic" | "inline" | "large"

/** Mirrors `ColorScheme`. */
export type ColorSchemeValue = "light" | "dark"

/** Mirrors `ToolbarRole`. */
export type ToolbarRole = "automatic" | "browser" | "editor"

/** Mirrors `TabBarMinimizeBehavior`. */
export type TabBarMinimizeBehavior = "automatic" | "onScrollDown" | "onScrollUp" | "never"

/** Mirrors `ContentMarginPlacement`. */
export type ContentMarginPlacement = "automatic" | "scrollContent" | "scrollIndicators"

/** Mirrors `PresentationDragIndicator`. */
export type PresentationDragIndicator = VisibilityKind

/** Mirrors the high-value `UIKeyboardType` / SwiftUI `.keyboardType(...)` cases SwiftJS supports. */
export type KeyboardType = "default" | "asciiCapable" | "numberPad" | "decimalPad" | "phonePad" | "emailAddress" | "URL"

/** Mirrors `TextInputAutocapitalization`. */
export type TextInputAutocapitalization = "never" | "words" | "sentences" | "characters"

/** Mirrors the `SubmitLabel` cases SwiftJS supports. */
export type SubmitLabel = "done" | "go" | "send" | "join" | "route" | "search" | "return" | "next" | "continue"

/** Mirrors common `SensoryFeedback` cases. */
export type SensoryFeedbackKind =
  | "selection"
  | "success"
  | "warning"
  | "error"
  | "increase"
  | "decrease"
  | "start"
  | "stop"
  | "alignment"
  | "levelChange"
  | "impact"

/** Mirrors common `SensoryFeedback.Weight` values for impact feedback. */
export type SensoryFeedbackWeight = "light" | "medium" | "heavy"

/** Mirrors common `SensoryFeedback.Flexibility` values for impact feedback. */
export type SensoryFeedbackFlexibility = "soft" | "solid" | "rigid"

/** Mirrors `.sensoryFeedback(_:trigger:)`. */
export type SensoryFeedbackValue = {
  feedback:
    | SensoryFeedbackKind
    | { impact: { weight?: SensoryFeedbackWeight; flexibility?: SensoryFeedbackFlexibility; intensity?: number } }
  trigger: CustomValue
  isEnabled?: boolean
}

/** Mirrors `fixedSize()` and `fixedSize(horizontal:vertical:)`. */
export type FixedSizeValue = boolean | { horizontal?: boolean; vertical?: boolean }

/** Mirrors `aspectRatio(_:contentMode:)`. */
export type AspectRatioValue = number | { value?: number; contentMode?: ImageContentMode }

/** Picker selection values supported by SwiftJS. */
export type PickerValue = string | number

/** Mirrors `SwiftUI.EditMode`. */
export type EditMode = "inactive" | "transient" | "active"

/** Selection values supported by `List(selection:)`. */
export type ListSelectionValue = PickerValue

/** Mirrors the payload emitted by SwiftUI list reordering. */
export type MoveAction = {
  fromOffsets: number[]
  toOffset: number
}

/** Mirrors the payload emitted by SwiftUI list deletion. */
export type DeleteAction = {
  offsets: number[]
}

/** Picker option values supported by SwiftJS. */
export type PickerOption = PickerValue | { title: string; value: PickerValue }

/** Mirrors the reusable `PickerStyle` overrides SwiftJS supports. */
export type PickerStyle = "inline" | "menu" | "segmented"

/** Date values accepted by `DatePicker`. */
export type DateValue = string | Date

/** Mirrors the common `DatePickerComponents` combinations. */
export type DatePickerDisplayedComponents = "date" | "hourAndMinute" | "dateAndTime"

/** Optional date bounds for `DatePicker`. */
export type DatePickerRange<Value extends DateValue = DateValue> = {
  start?: Value
  end?: Value
}

/** Numeric bounds accepted by `Slider` and `Stepper`. */
export type NumericRangeValue = {
  start: number
  end: number
}

/** Tab selection values supported by SwiftJS. */
export type TabValue = PickerValue

/** Badge payload supported by tabs. */
export type BadgeValue = string | number

/** Mirrors `ToolbarSpacer` sizing. */
export type ToolbarSpacerSizing = "fixed" | "flexible"

/** Mirrors the text styles SwiftJS maps to `SwiftUI.Font`. */
export type FontValue =
  | "largeTitle"
  | "title"
  | "title2"
  | "title3"
  | "headline"
  | "subheadline"
  | "body"
  | "callout"
  | "caption"
  | "caption2"
  | "footnote"
  | { system: { size: number; weight?: FontWeight } }

/** Mirrors the supported parts of `View.frame(...)`. */
export type FrameValue = {
  minWidth?: number
  minHeight?: number
  width?: number
  height?: number
  maxWidth?: number | "infinity"
  maxHeight?: number | "infinity"
}

/** Mirrors `EdgeInsets`. */
export type EdgeInsetsValue = {
  top?: number
  leading?: number
  bottom?: number
  trailing?: number
}

/** Mirrors `.safeAreaPadding`. */
export type SafeAreaPaddingValue = number | { edges?: EdgeSetValue; length: number }

/** Mirrors `.ignoresSafeArea`. */
export type IgnoresSafeAreaValue = boolean | { edges?: EdgeSetValue }

/** Mirrors `.contentMargins`. */
export type ContentMarginsValue = {
  edges?: EdgeSetValue
  amount: number
  placement?: ContentMarginPlacement
}

/** Mirrors `.safeAreaInset`. */
export type SafeAreaInsetValue = {
  edge: EdgeValue
  spacing?: number
  content: unknown
}

/** Mirrors `.tabViewBottomAccessory(isEnabled:content:)`. */
export type TabViewBottomAccessoryValue = {
  isEnabled?: boolean
  content: unknown
}

/** Mirrors `.toolbar`. */
export type ToolbarItemPlacement =
  | "automatic"
  | "principal"
  | "topBarLeading"
  | "topBarTrailing"
  | "bottomBar"
  | "status"
  | "cancellationAction"
  | "confirmationAction"
  | "destructiveAction"
  | "primaryAction"

/** Serializable toolbar item description. */
export type ToolbarItemValue =
  | {
      kind?: "item"
      placement?: ToolbarItemPlacement
      content: unknown
    }
  | {
      kind: "spacer"
      placement?: ToolbarItemPlacement
      sizing?: ToolbarSpacerSizing
    }

export type ToolbarItemContentValue = {
  placement?: ToolbarItemPlacement
  content: unknown
}

/** Mirrors `.toolbar`. */
export type ToolbarValue = ToolbarItemValue[]

/** Mirrors `SearchFieldPlacement.NavigationBarDrawerDisplayMode`. */
export type SearchFieldNavigationBarDrawerDisplayMode = "automatic" | "always"

/** Mirrors the common `SearchFieldPlacement` cases SwiftJS supports. */
export type SearchFieldPlacement =
  | "automatic"
  | "toolbar"
  | "toolbarPrincipal"
  | "sidebar"
  | "navigationBarDrawer"
  | { navigationBarDrawer: SearchFieldNavigationBarDrawerDisplayMode }

/** Mirrors `.searchable(text:prompt:)` with a writable text binding. */
export type SearchableValue = {
  text: string
  onChange: (nextValue: string) => void
  onSubmit?: () => void
  isPresented?: boolean
  onPresentationChange?: (nextValue: boolean) => void
  prompt?: string
  placement?: SearchFieldPlacement
}

/** Mirrors `.searchSuggestions { ... }`. */
export type SearchSuggestionsValue = unknown

/** Mirrors `.searchScopes` with a writable selection binding and tagged scope content. */
export type SearchScopesValue = {
  selection: PickerValue
  onChange: (nextValue: PickerValue) => void
  content: unknown
}

/** Mirrors `SwiftUI.ButtonRole`. */
export type ButtonRole = "cancel" | "destructive"

/** Mirrors `SearchPresentationToolbarBehavior`. */
export type SearchPresentationToolbarBehavior = "automatic" | "avoidHidingContent"

/** Mirrors `SearchToolbarBehavior`. */
export type SearchToolbarBehavior = "automatic" | "minimized"

/** Mirrors alert and confirmation dialog action roles. */
export type DialogActionRole = ButtonRole

/** Serializable dialog button description. */
export type DialogActionValue = {
  title: string
  role?: DialogActionRole
  action?: () => void
}

/** Mirrors `.alert`. */
export type AlertValue = {
  title: string
  isPresented: boolean
  message?: unknown
  actions?: DialogActionValue[]
}

/** Mirrors `.confirmationDialog`. */
export type ConfirmationDialogValue = {
  title: string
  isPresented: boolean
  titleVisibility?: VisibilityKind
  message?: unknown
  actions?: DialogActionValue[]
}

/** Mirrors `.contextMenu`, with optional preview content. */
export type ContextMenuValue =
  | DialogActionValue[]
  | {
      items: DialogActionValue[]
      preview?: unknown
    }

/** Mirrors `.swipeActions(edge:allowsFullSwipe:content:)`. */
export type SwipeActionsEntry = {
  items: unknown
  edge?: HorizontalEdgeValue
  allowsFullSwipe?: boolean
}

/** Mirrors one or more `.swipeActions(...)` modifiers. */
export type SwipeActionsValue = SwipeActionsEntry | SwipeActionsEntry[]

/** Mirrors `PresentationDetent`. */
export type PresentationDetentValue = "medium" | "large" | { fraction: number } | { height: number }

/** Mirrors `.presentationBackgroundInteraction`. */
export type PresentationBackgroundInteractionValue =
  | "automatic"
  | "enabled"
  | "disabled"
  | { upThrough: PresentationDetentValue }

/** Mirrors `Gradient.Stop`. */
export type GradientStop = {
  color: ColorValue
  location: number
}

/** Shared payload for `LinearGradient`. */
type LinearGradientBase = {
  colors?: ColorValue[]
  stops?: GradientStop[]
  startPoint: UnitPointValue
  endPoint: UnitPointValue
}

/** Shared payload for `RadialGradient`. */
type RadialGradientBase = {
  colors?: ColorValue[]
  stops?: GradientStop[]
  center?: UnitPointValue
  startRadius?: number
  endRadius: number
}

/** Shared payload for `AngularGradient`. */
type AngularGradientBase = {
  colors?: ColorValue[]
  stops?: GradientStop[]
  center?: UnitPointValue
  angle?: number
  startAngle?: number
  endAngle?: number
}

/** Serializable `LinearGradient` value for `background`, `foregroundStyle`, `fill`, or `stroke`. */
export type LinearGradientValue = { type: "LinearGradient" } & LinearGradientBase

/** Serializable `RadialGradient` value for `background`, `foregroundStyle`, `fill`, or `stroke`. */
export type RadialGradientValue = { type: "RadialGradient" } & RadialGradientBase

/** Serializable `AngularGradient` value for `background`, `foregroundStyle`, `fill`, or `stroke`. */
export type AngularGradientValue = { type: "AngularGradient" } & AngularGradientBase

/** Shared paint value accepted by view backgrounds and shape styling props. */
export type MaterialValue = "ultraThinMaterial" | "thinMaterial" | "regularMaterial" | "thickMaterial" | "ultraThickMaterial"

/** Shared paint value accepted by view backgrounds and shape styling props. */
export type ShapeStyleValue = ColorValue | MaterialValue | LinearGradientValue | RadialGradientValue | AngularGradientValue

/** Mirrors common SwiftUI accessibility traits. */
export type AccessibilityTraitValue =
  | "button"
  | "link"
  | "header"
  | "selected"
  | "image"
  | "staticText"
  | "summaryElement"
  | "updatesFrequently"
  | "searchField"
  | "isModal"

export type AccessibilityTraitsValue = AccessibilityTraitValue | AccessibilityTraitValue[]

/** One segment of a formatted SwiftUI `Text` value. */
export type TextSegmentValue = {
  text: string
  font?: FontValue
  fontWeight?: FontWeight
  foregroundColor?: ColorValue
  foregroundStyle?: ShapeStyleValue
}

/** Lightweight map marker used by `Map`. */
export type MapMarkerValue = {
  title: string
  latitude: number
  longitude: number
  systemName?: string
}

/** Serializable chart point used by `Chart`. */
export type ChartPointValue = {
  label: string
  value: number
  series?: string
}

/** Chart mark kinds supported by SwiftJS. */
export type ChartMarkKind = "bar" | "line" | "point" | "area"

/** Mirrors high-value `UITextContentType` cases for text inputs. */
export type TextContentType =
  | "name"
  | "givenName"
  | "familyName"
  | "username"
  | "emailAddress"
  | "password"
  | "newPassword"
  | "oneTimeCode"
  | "URL"
  | "telephoneNumber"

/** Serializable transfer payload used by `draggable` and `dropDestination`. */
export type TransferItemValue =
  | string
  | {
      kind: "text"
      value: string
      contentType?: string
      suggestedName?: string
    }
  | {
      kind: "url"
      value: string
      contentType?: string
      suggestedName?: string
    }
  | {
      kind: "file"
      value: string
      contentType?: string
      suggestedName?: string
    }
  | {
      kind: "data"
      value: string
      contentType: string
      suggestedName?: string
    }

/** Drop location emitted by `dropDestination`. */
export type DropLocationValue = {
  x: number
  y: number
}

/** Decoded drop items passed to `dropDestination.action`. */
export type DroppedTransferItemValue = Exclude<TransferItemValue, string>

/**
 * Reduced `.dropDestination(...)` subset.
 * SwiftJS notifies JS after accepted providers load, but JS cannot veto the drop result.
 */
export type DropDestinationValue = {
  contentTypes?: string[]
  action: (items: DroppedTransferItemValue[], location: DropLocationValue) => void
  isTargeted?: (isTargeted: boolean) => void
}

/**
 * Shared modifiers available on all built-in SwiftJS host views.
 *
 * const props: ViewProps = {
 *   padding: 16,
 *   background: "secondarySystemBackground",
 *   navigationTitle: "Inbox",
 * }
 */
export type ViewProps = {
  id?: string
  key?: string | number
  viewID?: string | number | boolean
  tag?: PickerValue
  children?: unknown
  /** Overrides the spoken label for assistive technologies. */
  accessibilityLabel?: string
  accessibilityHint?: string
  accessibilityValue?: string
  accessibilityAddTraits?: AccessibilityTraitsValue
  accessibilityRemoveTraits?: AccessibilityTraitsValue
  padding?: number
  paddingTop?: number
  frame?: FrameValue
  alignment?: ContentAlignment
  background?: ShapeStyleValue
  foregroundColor?: ColorValue
  foregroundStyle?: ShapeStyleValue
  tint?: ColorValue
  badge?: BadgeValue
  cornerRadius?: number
  navigationTitle?: string
  navigationBarTitleDisplayMode?: NavigationBarTitleDisplayMode
  /** Controls the chevron visibility SwiftUI applies to navigation links. */
  navigationLinkIndicatorVisibility?: VisibilityKind
  tabBarMinimizeBehavior?: TabBarMinimizeBehavior
  tabViewBottomAccessory?: TabViewBottomAccessoryValue
  toolbarRole?: ToolbarRole
  searchSuggestions?: SearchSuggestionsValue
  searchScopes?: SearchScopesValue
  searchCompletion?: string
  searchPresentationToolbarBehavior?: SearchPresentationToolbarBehavior
  searchToolbarBehavior?: SearchToolbarBehavior
  toolbar?: ToolbarValue
  toolbarBackgroundVisibility?: VisibilityKind
  toolbarColorScheme?: ColorSchemeValue
  listStyle?: ListStyle
  pickerStyle?: PickerStyle
  scrollContentBackground?: VisibilityKind
  listRowSeparator?: VisibilityKind
  listSectionSeparator?: VisibilityKind
  listRowInsets?: EdgeInsetsValue
  listRowBackground?: ShapeStyleValue
  draggable?: TransferItemValue
  dropDestination?: DropDestinationValue
  contentMargins?: ContentMarginsValue | ContentMarginsValue[]
  imageContentMode?: ImageContentMode
  aspectRatio?: AspectRatioValue
  fixedSize?: FixedSizeValue
  keyboardType?: KeyboardType
  textInputAutocapitalization?: TextInputAutocapitalization
  autocorrectionDisabled?: boolean
  submitLabel?: SubmitLabel
  onSubmit?: () => void
  sensoryFeedback?: SensoryFeedbackValue
  safeAreaPadding?: SafeAreaPaddingValue
  ignoresSafeArea?: IgnoresSafeAreaValue
  safeAreaInset?: SafeAreaInsetValue | SafeAreaInsetValue[]
  symbolRenderingMode?: SymbolRenderingMode
  buttonStyle?: ButtonStyle
  buttonBorderShape?: ButtonBorderShape
  buttonSizing?: ButtonSizing
  contentShape?: ContentShapeValue
  clipShape?: ShapeValue
  disabled?: boolean
  moveDisabled?: boolean
  glassEffect?: GlassEffectValue
  scrollEdgeEffectStyle?: ScrollEdgeEffectValue
  editMode?: EditMode
  onEditModeChange?: (nextValue: EditMode) => void
  lineLimit?: number
  lineSpacing?: number
  multilineTextAlignment?: TextAlignmentValue
  truncationMode?: TruncationMode
  minimumScaleFactor?: number
  alert?: AlertValue
  confirmationDialog?: ConfirmationDialogValue
  contextMenu?: ContextMenuValue
  swipeActions?: SwipeActionsValue
  onAppear?: () => void
}

/** Shared props for `VStack`, `HStack`, and `ZStack`. */
export type StackProps = ViewProps & {
  distribution?: StackDistribution
  spacing?: number
}

/** Props for `Grid`. */
export type GridProps = ViewProps & {
  horizontalSpacing?: number
  verticalSpacing?: number
}

/** Props for `GridRow`. */
export type GridRowProps = ViewProps

/** Props for `FlowLayout`. */
export type FlowLayoutProps = ViewProps & {
  spacing?: number
  lineSpacing?: number
}

/** Props for `ViewThatFits`. */
export type ViewThatFitsProps = ViewProps & {
  axis?: AxisValue
}

/** Props for `ScrollView`. */
export type ScrollViewProps = ViewProps & {
  axis?: AxisValue
  searchable?: SearchableValue
}

/** Mirrors `GeometryProxy.size`. */
export type GeometrySize = {
  width: number
  height: number
}

/** Minimal `GeometryProxy` surface exposed by SwiftJS. */
export type GeometryProxy = {
  size: GeometrySize
}

/** Props for `GeometryReader`. */
export type GeometryReaderProps = ViewProps & {
  children: ((proxy: GeometryProxy) => unknown) | Array<(proxy: GeometryProxy) => unknown>
}

/** Props for `Section`. */
export type SectionProps = ViewProps & {
  title?: string
  header?: unknown
  footer?: unknown
}

/** Props for `Form`. */
export type FormProps = ViewProps & {
  searchable?: SearchableValue
}

export type NavigationStackProps = ViewProps & {
  searchable?: SearchableValue
  path?: CustomValue[]
  onPathChange?: (nextPath: CustomValue[]) => void
  navigationDestination?: (value: CustomValue) => unknown
}

/** Props for `ForEach`, used to carry row-level move handling. */
export type ForEachProps<Item = unknown> = ViewProps & {
  data?: readonly Item[]
  id?: keyof Item | ((item: Item, index: number) => string | number)
  children?: unknown | ((item: Item, index: number) => unknown)
  onMove?: (action: MoveAction) => void
  onDelete?: (action: DeleteAction) => void
}

/** Props for `NavigationLink`. */
export type NavigationLinkProps = ViewProps &
  (
    | { destination: unknown; value?: never }
    | { destination?: never; value: CustomValue }
  )

/** Explicit share payloads supported by `ShareLink`. */
export type ShareItemValue = string | { kind: "text"; value: string } | { kind: "url"; value: string }

/** Props for `Link`. */
export type LinkProps = ViewProps & {
  destination: string
}

/** Props for `WebView`. */
export type WebViewProps = ViewProps & {
  url?: string
  html?: string
  baseURL?: string
  javaScriptEnabled?: boolean
  allowsBackForwardNavigationGestures?: boolean
}

/** Props for `ShareLink`. */
export type ShareLinkProps = ViewProps &
  (
    | { item: ShareItemValue; items?: never }
    | { item?: never; items: ShareItemValue[] }
  ) & {
  subject?: string
  message?: string
}

type PresentationProps = ViewProps & {
  onDismiss?: () => void
  presentationDetents?: PresentationDetentValue[]
  presentationDragIndicator?: PresentationDragIndicator
  presentationCornerRadius?: number
  presentationBackgroundInteraction?: PresentationBackgroundInteractionValue
  interactiveDismissDisabled?: boolean
}

/** Props for `Sheet`. */
export type SheetProps<Item = unknown> =
  | (PresentationProps & { isPresented: boolean; item?: never; content: unknown | (() => unknown) })
  | (PresentationProps & { isPresented?: never; item: Item | null | undefined; content: (item: Item) => unknown })

/** Props for `FullScreenCover`. */
export type FullScreenCoverProps<Item = unknown> =
  | (PresentationProps & { isPresented: boolean; item?: never; content: unknown | (() => unknown) })
  | (PresentationProps & { isPresented?: never; item: Item | null | undefined; content: (item: Item) => unknown })

/** Props for `TabView`. */
export type TabViewProps = ViewProps & {
  selection?: TabValue
  onSelectionChange?: (nextValue: TabValue) => void
}

/** Props for `Tab`. */
export type TabProps = ViewProps & {
  title: string
  value?: TabValue
  systemName?: string
  name?: string
  badge?: BadgeValue
  role?: TabRole
  tabRole?: TabRole
}

/** Props for `Menu`. */
export type MenuProps = ViewProps & {
  content: unknown
}

/** Props for `DisclosureGroup`. */
export type DisclosureGroupProps = ViewProps & {
  isExpanded: boolean
  onExpandedChange: (nextValue: boolean) => void
  content: unknown
}

/** Props for `ControlGroup`. */
export type ControlGroupProps = ViewProps

/** Props for `GroupBox`. */
export type GroupBoxProps = ViewProps & {
  title?: string
  label?: unknown
}

/** JSON-compatible values passed through custom host props. */
export type CustomValue = string | number | boolean | CustomValue[] | { [key: string]: CustomValue }

/** Props for `Custom`. */
export type CustomProps = ViewProps & {
  name: string
  values?: Record<string, CustomValue>
  slots?: Record<string, unknown>
}

/** Mirrors the subset of `ProposedViewSize` exposed to custom layouts. */
export type ProposedViewSize = {
  width?: number
  height?: number
  replacingUnspecifiedDimensions: (replacement: { width: number; height: number }) => { width: number; height: number }
}

/** Bounds payload passed to custom layout placement. */
export type LayoutBounds = {
  minX: number
  minY: number
  width: number
  height: number
}

/** Minimal layout subview proxy exposed to JS layouts. */
export type LayoutSubview = {
  sizeThatFits: (proposal: { width?: number; height?: number }) => { width?: number; height?: number }
}

/** Placement instruction returned from JS custom layouts. */
export type LayoutPlacement = {
  x: number
  y: number
  anchor: ContentAlignment
  width?: number
  height?: number
}

/** Props for `CustomLayout`. */
export type CustomLayoutProps = ViewProps & {
  name: string
  values?: Record<string, CustomValue>
  sizeThatFits?: (proposal: ProposedViewSize, subviews: LayoutSubview[]) => { width?: number; height?: number }
  placeSubviews?: (bounds: LayoutBounds, proposal: ProposedViewSize, subviews: LayoutSubview[]) => LayoutPlacement[]
}

/** Props for `NavigationSplitView`. */
export type NavigationSplitViewProps = ViewProps & {
  sidebar: unknown
  detail: unknown
  searchable?: SearchableValue
}

export type TextProps = ViewProps & {
  font?: FontValue
  fontWeight?: FontWeight
  segments?: TextSegmentValue[]
}

/** Shared props for shape hosts. */
export type ShapeProps = ViewProps & {
  fill?: ShapeStyleValue
  stroke?: ShapeStyleValue
  lineWidth?: number
}

/** Props for `Rectangle`. */
export type RectangleProps = ShapeProps

/** Props for `Circle`. */
export type CircleProps = ShapeProps

/** Props for `Capsule`. */
export type CapsuleProps = ShapeProps

/** Props for `Ellipse`. */
export type EllipseProps = ShapeProps

/** Props for `RoundedRectangle`. */
export type RoundedRectangleProps = ShapeProps & {
  cornerRadius: number
}

/** Props for `LinearGradient`. */
export type LinearGradientProps = ViewProps & LinearGradientBase

/** Props for `RadialGradient`. */
export type RadialGradientProps = ViewProps & RadialGradientBase

/** Props for `AngularGradient`. */
export type AngularGradientProps = ViewProps & AngularGradientBase

export type ButtonProps = ViewProps & {
  action: () => void
  role?: ButtonRole
  font?: FontValue
  fontWeight?: FontWeight
}

/** Props for `TextField`. */
export type TextFieldProps = ViewProps & {
  text: string
  onChange: (nextValue: string) => void
  title?: string
  prompt?: string
  textContentType?: TextContentType
  font?: FontValue
  fontWeight?: FontWeight
}

/** Props for `SecureField`. */
export type SecureFieldProps = ViewProps & {
  text: string
  onChange: (nextValue: string) => void
  title?: string
  prompt?: string
  textContentType?: TextContentType
  font?: FontValue
  fontWeight?: FontWeight
}

/** Props for `TextEditor`. */
export type TextEditorProps = ViewProps & {
  text: string
  onChange: (nextValue: string) => void
  font?: FontValue
  fontWeight?: FontWeight
}

/** Props for `Picker`. */
export type PickerProps = ViewProps & {
  selection: PickerValue
  title?: string
  label?: unknown
  options?: PickerOption[]
  onChange: (nextValue: PickerValue) => void
}

/** Props for `Slider`. */
export type SliderProps = ViewProps & {
  value: number
  onChange: (nextValue: number) => void
  range: NumericRangeValue
  step?: number
}

/** Props for `Stepper`. */
export type StepperProps = ViewProps & {
  value: number
  onChange: (nextValue: number) => void
  range: NumericRangeValue
  step?: number
}

/** Props for `DatePicker`. */
export type DatePickerProps<Value extends DateValue = DateValue> = ViewProps & {
  selection: Value
  onChange: (nextValue: Value) => void
  displayedComponents?: DatePickerDisplayedComponents
  range?: DatePickerRange<Value>
}

/** Props for `Toggle`. */
export type ToggleProps = ViewProps & {
  isOn: boolean
  onChange: (nextValue: boolean) => void
}

/** Props for `Image`. */
export type ImageProps = ViewProps & {
  systemName?: string
  name?: string
  interpolation?: ImageInterpolation
  font?: FontValue
  fontWeight?: FontWeight
}

/** Props for `AsyncImage`. */
export type AsyncImageProps = ViewProps & {
  url: string
  placeholder?: unknown
  empty?: unknown
  failure?: unknown
}

/** Props for `Map`. */
export type MapProps = ViewProps & {
  latitude: number
  longitude: number
  latitudeDelta?: number
  longitudeDelta?: number
  markers?: MapMarkerValue[]
}

/** Props for `Chart`. */
export type ChartProps = ViewProps & {
  data: ChartPointValue[]
  mark?: ChartMarkKind
}

/** Props for `VideoPlayer`. */
export type VideoPlayerProps = ViewProps & {
  url: string
}

/** Props for `GlassEffectContainer`. */
export type GlassEffectContainerProps = ViewProps & {
  spacing?: number
}

/** Props for `Label`. */
export type LabelProps = ViewProps & {
  title: string
  systemName?: string
  name?: string
  font?: FontValue
  fontWeight?: FontWeight
}

export type ContentUnavailableProps = ViewProps & {
  /** Primary message. */
  title: string
  /** SF Symbol name. */
  systemName?: string
  /** Asset image name. */
  name?: string
  /** Secondary content. */
  description?: unknown
}

/** Props for `ProgressView`. */
export type ProgressViewProps = ViewProps & {
  /** Optional completed work value. */
  value?: number
  /** Optional total work value. Requires `value`. */
  total?: number
  /** Optional label content. */
  label?: unknown
  /** Optional current-value label content. Requires `value`. */
  currentValueLabel?: unknown
}

/** Props for `Divider`. */
export type DividerProps = ViewProps

/** Props for `Spacer`. */
export type SpacerProps = ViewProps

/** Props for `List`. */
export type ListProps<Item = unknown> = ViewProps & {
  searchable?: SearchableValue
  selection?: ReadonlySet<ListSelectionValue>
  onSelectionChange?: (nextValue: Set<ListSelectionValue>) => void
  data?: readonly Item[]
  id?: keyof Item | ((item: Item, index: number) => string | number)
  children?: unknown | ((item: Item, index: number) => unknown)
}

/** Props for `EditButton`. */
export type EditButtonProps = ViewProps
export type TabRole = "search"
