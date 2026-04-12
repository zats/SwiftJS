import type {
  AlertValue,
  ButtonBorderShape,
  ButtonStyle,
  ColorSchemeValue,
  ContentMarginsValue,
  NavigationBarTitleDisplayMode,
  PresentationBackgroundInteractionValue,
  PresentationDetentValue,
  PresentationDragIndicator,
  ToolbarValue,
  TruncationMode,
  VisibilityKind,
} from "../swiftjs"

export const space = {
  xxs: 4,
  xs: 6,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  xxl: 28,
} as const

export type ShellProps = {
  title: string
  displayMode?: NavigationBarTitleDisplayMode
  toolbar?: ToolbarValue
  toolbarBackgroundVisibility?: VisibilityKind
  toolbarColorScheme?: ColorSchemeValue
  safeAreaInset?: unknown
  alert?: AlertValue
  confirmationDialog?: unknown
  children?: unknown
}

export type SectionProps = {
  title: string
  detail?: string
  children?: unknown
}

export type CardProps = {
  title: string
  detail?: string
  children?: unknown
}

export type LinkVariantProps = {
  title: string
  detail: string
  indicator: VisibilityKind
}

export type ChromePreviewProps = {
  title: string
  displayMode: NavigationBarTitleDisplayMode
  toolbarBackgroundVisibility: VisibilityKind
  toolbarColorScheme?: ColorSchemeValue
}

export type SheetLauncherProps = {
  title: string
  detents: PresentationDetentValue[]
  dragIndicator: PresentationDragIndicator
  backgroundInteraction: PresentationBackgroundInteractionValue
  interactiveDismissDisabled?: boolean
}

export type ListPreviewProps = {
  title: string
  style: "automatic" | "plain" | "grouped" | "inset" | "insetGrouped" | "sidebar"
  scrollContentBackground?: VisibilityKind
  listRowSeparator?: VisibilityKind
  listSectionSeparator?: VisibilityKind
  listRowBackground?: string
  listRowInsets?: { top?: number; leading?: number; bottom?: number; trailing?: number }
  contentMargins?: ContentMarginsValue | ContentMarginsValue[]
}

export type FixedTextProps = {
  title: string
  fixedSize: boolean | { horizontal?: boolean; vertical?: boolean }
}

export const buttonStyles: ButtonStyle[] = [
  "automatic",
  "plain",
  "borderless",
  "bordered",
  "borderedProminent",
  "glass",
  "glassProminent",
]

export const buttonShapes: ButtonBorderShape[] = ["automatic", "capsule", "roundedRectangle", "circle"]
export const truncationModes: TruncationMode[] = ["head", "middle", "tail"]
