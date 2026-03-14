export type ColorValue = "red" | "green" | "yellow" | "blue" | "orange" | "mint" | "white" | "secondary"
export type FontWeight = "regular" | "medium" | "semibold" | "bold"
export type SymbolRenderingMode = "monochrome" | "hierarchical" | "multicolor"
export type ButtonStyle = "plain" | "bordered" | "borderedProminent" | "glass" | "glassProminent"
export type ButtonBorderShape = "automatic" | "capsule" | "roundedRectangle" | "circle"
export type GlassEffectValue = boolean | { tint?: ColorValue }
export type FontValue =
  | "largeTitle"
  | "title"
  | "body"
  | "caption"
  | { system: { size: number; weight?: FontWeight } }

export type FrameValue = {
  width?: number
  height?: number
}

export type ViewProps = {
  id?: string
  children?: unknown
  padding?: number
  paddingTop?: number
  frame?: FrameValue
  background?: ColorValue
  foregroundColor?: ColorValue
  cornerRadius?: number
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
  systemName: string
  font?: FontValue
  fontWeight?: FontWeight
}

export type DividerProps = ViewProps
