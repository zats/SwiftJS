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
  children?: unknown
  padding?: number
  paddingTop?: number
  frame?: FrameValue
  alignment?: ContentAlignment
  background?: ColorValue
  foregroundColor?: ColorValue
  cornerRadius?: number
  navigationTitle?: string
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

export type SectionProps = ViewProps & {
  title?: string
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

export type ImageProps = ViewProps & {
  systemName?: string
  name?: string
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
