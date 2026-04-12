/**
 * Shared value and prop types for the SwiftJS TSX surface.
 *
 * const frame: FrameValue = { maxWidth: "infinity", minHeight: 160 }
 * const detents: PresentationDetentValue[] = ["medium", { height: 220 }]
 */
/** Accepts any named or hex color SwiftJS can resolve to `SwiftUI.Color`. */
export type ColorValue = string

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

/** Mirrors the liquid glass variants SwiftJS supports. */
export type GlassEffectValue = boolean | "clear" | { variant?: "regular" | "clear"; tint?: ColorValue }

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

/** Mirrors `ContentMarginPlacement`. */
export type ContentMarginPlacement = "automatic" | "scrollContent" | "scrollIndicators"

/** Mirrors `PresentationDragIndicator`. */
export type PresentationDragIndicator = VisibilityKind

/** Mirrors `fixedSize()` and `fixedSize(horizontal:vertical:)`. */
export type FixedSizeValue = boolean | { horizontal?: boolean; vertical?: boolean }

/** Mirrors `aspectRatio(_:contentMode:)`. */
export type AspectRatioValue = number | { value?: number; contentMode?: ImageContentMode }

/** Picker selection values supported by SwiftJS. */
export type PickerValue = string | number

/** Picker option values supported by SwiftJS. */
export type PickerOption = PickerValue | { title: string; value: PickerValue }

/** Tab selection values supported by SwiftJS. */
export type TabValue = PickerValue

/** Badge payload supported by tabs. */
export type BadgeValue = string | number

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
  | "primaryAction"

/** Serializable toolbar item description. */
export type ToolbarItemValue = {
  placement?: ToolbarItemPlacement
  content: unknown
}

/** Mirrors `.toolbar`. */
export type ToolbarValue = ToolbarItemValue[]

/** Mirrors alert and confirmation dialog action roles. */
export type DialogActionRole = "cancel" | "destructive"

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
export type ShapeStyleValue = ColorValue | LinearGradientValue | RadialGradientValue | AngularGradientValue

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
  children?: unknown
  padding?: number
  paddingTop?: number
  frame?: FrameValue
  alignment?: ContentAlignment
  background?: ShapeStyleValue
  foregroundColor?: ColorValue
  foregroundStyle?: ShapeStyleValue
  tint?: ColorValue
  cornerRadius?: number
  navigationTitle?: string
  navigationBarTitleDisplayMode?: NavigationBarTitleDisplayMode
  /** Controls the chevron visibility SwiftUI applies to navigation links. */
  navigationLinkIndicatorVisibility?: VisibilityKind
  toolbar?: ToolbarValue
  toolbarBackgroundVisibility?: VisibilityKind
  toolbarColorScheme?: ColorSchemeValue
  listStyle?: ListStyle
  scrollContentBackground?: VisibilityKind
  listRowSeparator?: VisibilityKind
  listSectionSeparator?: VisibilityKind
  listRowInsets?: EdgeInsetsValue
  listRowBackground?: ShapeStyleValue
  contentMargins?: ContentMarginsValue | ContentMarginsValue[]
  imageContentMode?: ImageContentMode
  aspectRatio?: AspectRatioValue
  fixedSize?: FixedSizeValue
  safeAreaPadding?: SafeAreaPaddingValue
  ignoresSafeArea?: IgnoresSafeAreaValue
  safeAreaInset?: SafeAreaInsetValue | SafeAreaInsetValue[]
  symbolRenderingMode?: SymbolRenderingMode
  buttonStyle?: ButtonStyle
  buttonBorderShape?: ButtonBorderShape
  disabled?: boolean
  glassEffect?: GlassEffectValue
  lineLimit?: number
  multilineTextAlignment?: TextAlignmentValue
  truncationMode?: TruncationMode
  minimumScaleFactor?: number
  alert?: AlertValue
  confirmationDialog?: ConfirmationDialogValue
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
}

/** Props for `Form`. */
export type FormProps = ViewProps

export type NavigationStackProps = ViewProps

/** Props for `NavigationLink`. */
export type NavigationLinkProps = ViewProps & {
  destination: unknown
}

/** Props for `Sheet`. */
export type SheetProps = ViewProps & {
  isPresented: boolean
  onDismiss?: () => void
  content: unknown
  presentationDetents?: PresentationDetentValue[]
  presentationDragIndicator?: PresentationDragIndicator
  presentationCornerRadius?: number
  presentationBackgroundInteraction?: PresentationBackgroundInteractionValue
  interactiveDismissDisabled?: boolean
}

/** Props for `FullScreenCover`. */
export type FullScreenCoverProps = ViewProps & {
  isPresented: boolean
  onDismiss?: () => void
  content: unknown
  interactiveDismissDisabled?: boolean
}

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

/** JSON-compatible values passed through custom host props. */
export type CustomValue = string | number | boolean | CustomValue[] | { [key: string]: CustomValue }

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
}

export type TextProps = ViewProps & {
  font?: FontValue
  fontWeight?: FontWeight
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
  font?: FontValue
  fontWeight?: FontWeight
}

/** Props for `Picker`. */
export type PickerProps = ViewProps & {
  selection: PickerValue
  options: PickerOption[]
  onChange: (nextValue: PickerValue) => void
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

/** Props for `Divider`. */
export type DividerProps = ViewProps

/** Props for `Spacer`. */
export type SpacerProps = ViewProps

/** Props for `List`. */
export type ListProps = ViewProps
