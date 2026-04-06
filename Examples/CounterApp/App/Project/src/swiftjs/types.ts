export type ColorValue = string
export type FontWeight = "regular" | "medium" | "semibold" | "bold"
export type SymbolRenderingMode = "monochrome" | "hierarchical" | "multicolor"
export type ButtonStyle = "plain" | "bordered" | "borderedProminent" | "glass" | "glassProminent"
export type ButtonBorderShape = "automatic" | "capsule" | "roundedRectangle" | "circle"
/** Mirrors SwiftUI.Visibility for navigation link indicators. */
export type VisibilityKind = "automatic" | "visible" | "hidden"
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
export type UnitPointValue = ContentAlignment
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

export type GradientStop = {
  color: ColorValue
  location: number
}

type LinearGradientBase = {
  colors?: ColorValue[]
  stops?: GradientStop[]
  startPoint: UnitPointValue
  endPoint: UnitPointValue
}

type RadialGradientBase = {
  colors?: ColorValue[]
  stops?: GradientStop[]
  center?: UnitPointValue
  startRadius?: number
  endRadius: number
}

type AngularGradientBase = {
  colors?: ColorValue[]
  stops?: GradientStop[]
  center?: UnitPointValue
  angle?: number
  startAngle?: number
  endAngle?: number
}

export type LinearGradientValue = { type: "LinearGradient" } & LinearGradientBase
export type RadialGradientValue = { type: "RadialGradient" } & RadialGradientBase
export type AngularGradientValue = { type: "AngularGradient" } & AngularGradientBase
export type ShapeStyleValue = ColorValue | LinearGradientValue | RadialGradientValue | AngularGradientValue

export type ViewProps = {
  id?: string
  children?: unknown
  padding?: number
  paddingTop?: number
  frame?: FrameValue
  alignment?: ContentAlignment
  background?: ShapeStyleValue
  foregroundColor?: ColorValue
  foregroundStyle?: ShapeStyleValue
  cornerRadius?: number
  /** Controls the chevron visibility SwiftUI applies to navigation links. */
  navigationLinkIndicatorVisibility?: VisibilityKind
  symbolRenderingMode?: SymbolRenderingMode
  buttonStyle?: ButtonStyle
  buttonBorderShape?: ButtonBorderShape
  disabled?: boolean
  glassEffect?: GlassEffectValue
  onAppear?: () => void
}

export type StackProps = ViewProps & {
  spacing?: number
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

export type ShapeProps = ViewProps & {
  fill?: ShapeStyleValue
  stroke?: ShapeStyleValue
  lineWidth?: number
}

export type RectangleProps = ShapeProps
export type RoundedRectangleProps = ShapeProps & {
  cornerRadius: number
}
export type CircleProps = ShapeProps
export type CapsuleProps = ShapeProps
export type EllipseProps = ShapeProps
export type LinearGradientProps = ViewProps & LinearGradientBase
export type RadialGradientProps = ViewProps & RadialGradientBase
export type AngularGradientProps = ViewProps & AngularGradientBase

export type DividerProps = ViewProps
