export type ColorValue = string
export type FontWeight = "regular" | "medium" | "semibold" | "bold"
export type SymbolRenderingMode = "monochrome" | "hierarchical" | "multicolor"
export type ButtonStyle = "plain" | "bordered" | "borderedProminent" | "glass" | "glassProminent"
export type ButtonBorderShape = "automatic" | "capsule" | "roundedRectangle" | "circle"
export type GlassEffectValue = boolean | { tint?: ColorValue }
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
export type AxisValue = "vertical" | "horizontal"
export type StackDistribution = "natural" | "fillEqually"
export type ListStyle = "automatic" | "plain" | "insetGrouped" | "sidebar"
export type ImageContentMode = "fit" | "fill"
export type ImageInterpolation = "none" | "low" | "medium" | "high"
/** Mirrors SwiftUI.Visibility for navigation link indicators. */
export type VisibilityKind = "automatic" | "visible" | "hidden"
export type FixedSizeValue = boolean | { horizontal?: boolean; vertical?: boolean }
export type AspectRatioValue = number | { value?: number; contentMode?: ImageContentMode }
export type FontValue =
  | "largeTitle"
  | "title"
  | "title2"
  | "headline"
  | "subheadline"
  | "body"
  | "caption"
  | "footnote"
  | { system: { size: number; weight?: FontWeight } }

export type FrameValue = {
  minWidth?: number
  minHeight?: number
  width?: number
  height?: number
  maxWidth?: number | "infinity"
  maxHeight?: number | "infinity"
}

export type ViewProps = {
  id?: string
  viewID?: string | number | boolean
  children?: unknown
  padding?: number
  paddingTop?: number
  frame?: FrameValue
  alignment?: ContentAlignment
  background?: ColorValue
  foregroundColor?: ColorValue
  cornerRadius?: number
  navigationTitle?: string
  /** Controls the chevron visibility SwiftUI applies to navigation links. */
  navigationLinkIndicatorVisibility?: VisibilityKind
  listStyle?: ListStyle
  imageContentMode?: ImageContentMode
  aspectRatio?: AspectRatioValue
  fixedSize?: FixedSizeValue
  compactVertical?: boolean
  symbolRenderingMode?: SymbolRenderingMode
  buttonStyle?: ButtonStyle
  buttonBorderShape?: ButtonBorderShape
  disabled?: boolean
  glassEffect?: GlassEffectValue
  onAppear?: () => void
}

export type StackProps = ViewProps & {
  distribution?: StackDistribution
  spacing?: number
}

export type GridProps = ViewProps & {
  horizontalSpacing?: number
  verticalSpacing?: number
}

export type GridRowProps = ViewProps
export type FlowLayoutProps = ViewProps & {
  spacing?: number
  lineSpacing?: number
}

export type ScrollViewProps = ViewProps & {
  axis?: AxisValue
}

export type GeometrySize = {
  width: number
  height: number
}

export type GeometryProxy = {
  size: GeometrySize
}

export type GeometryReaderProps = ViewProps & {
  children: ((proxy: GeometryProxy) => unknown) | Array<(proxy: GeometryProxy) => unknown>
}

export type SectionProps = ViewProps & {
  title?: string
}

export type FormProps = ViewProps

export type NavigationStackProps = ViewProps

export type NavigationLinkProps = ViewProps & {
  destination: unknown
}

export type CustomValue = string | number | boolean | CustomValue[] | { [key: string]: CustomValue }

export type ProposedViewSize = {
  width?: number
  height?: number
  replacingUnspecifiedDimensions: (replacement: { width: number; height: number }) => { width: number; height: number }
}

export type LayoutBounds = {
  minX: number
  minY: number
  width: number
  height: number
}

export type LayoutSubview = {
  sizeThatFits: (proposal: { width?: number; height?: number }) => { width?: number; height?: number }
}

export type LayoutPlacement = {
  x: number
  y: number
  anchor: ContentAlignment
  width?: number
  height?: number
}

export type CustomLayoutProps = ViewProps & {
  name: string
  values?: Record<string, CustomValue>
  sizeThatFits?: (proposal: ProposedViewSize, subviews: LayoutSubview[]) => { width?: number; height?: number }
  placeSubviews?: (bounds: LayoutBounds, proposal: ProposedViewSize, subviews: LayoutSubview[]) => LayoutPlacement[]
}

export type NavigationSplitViewProps = ViewProps & {
  sidebar: unknown
  detail: unknown
}

export type TextProps = ViewProps & {
  font?: FontValue
  fontWeight?: FontWeight
}

export type ButtonProps = ViewProps & {
  action: () => void
  font?: FontValue
  fontWeight?: FontWeight
}

export type ToggleProps = ViewProps & {
  isOn: boolean
  onChange: (nextValue: boolean) => void
}

export type ImageProps = ViewProps & {
  systemName?: string
  name?: string
  interpolation?: ImageInterpolation
  font?: FontValue
  fontWeight?: FontWeight
}

export type LabelProps = ViewProps & {
  title: string
  systemName?: string
  name?: string
  font?: FontValue
  fontWeight?: FontWeight
}

export type DividerProps = ViewProps
export type SpacerProps = ViewProps
export type ListProps = ViewProps
