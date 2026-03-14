import type {
  AspectRatioValue,
  ButtonProps,
  DividerProps,
  FlowLayoutProps,
  GridProps,
  GridRowProps,
  ImageProps,
  LabelProps,
  ListProps,
  NavigationSplitViewProps,
  ScrollViewProps,
  SectionProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  TextProps,
  WidthThresholdProps,
} from "./types"

export type {
  AspectRatioValue,
  AxisValue,
  ButtonBorderShape,
  ButtonProps,
  ButtonStyle,
  ColorValue,
  ContentAlignment,
  DividerProps,
  FontValue,
  FontWeight,
  FlowLayoutProps,
  FrameValue,
  FixedSizeValue,
  GlassEffectValue,
  GridProps,
  GridRowProps,
  ImageContentMode,
  ImageProps,
  LabelProps,
  ListProps,
  ListStyle,
  NavigationSplitViewProps,
  ScrollViewProps,
  SectionProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  SymbolRenderingMode,
  TextProps,
  ViewProps,
  WidthThresholdProps,
} from "./types"

export type Runtime = {
  Fragment: symbol
  createElement: (type: unknown, props?: Record<string, unknown>, ...children: unknown[]) => unknown
  mount: (component: () => unknown) => void
  useEffect: (effect: () => void | (() => void), deps?: unknown[]) => void
  useRef: <Value>(initialValue: Value) => { current: Value }
  useState: <Value>(
    initialValue: Value | (() => Value)
  ) => [Value, (nextValue: Value | ((current: Value) => Value)) => void]
}

declare global {
  var __swiftjsRuntime: Runtime | undefined
}

function runtime(): Runtime {
  if (!globalThis.__swiftjsRuntime) {
    throw new Error("swiftjs runtime bridge is missing")
  }

  return globalThis.__swiftjsRuntime
}

function hostComponent<Props>(name: string) {
  return function HostComponent(props: Props) {
    return runtime().createElement(name, props as Record<string, unknown>)
  }
}

export const Fragment = runtime().Fragment
export const createElement = (type: unknown, props?: Record<string, unknown>, ...children: unknown[]) =>
  runtime().createElement(type, props, ...children)
export const useState = <Value,>(initialValue: Value | (() => Value)) => runtime().useState(initialValue)
export const useEffect = (effect: () => void | (() => void), deps?: unknown[]) => runtime().useEffect(effect, deps)
export const useRef = <Value,>(initialValue: Value) => runtime().useRef(initialValue)
export const mount = (component: () => unknown) => runtime().mount(component)

export const VStack = hostComponent<StackProps>("VStack")
export const HStack = hostComponent<StackProps>("HStack")
export const ZStack = hostComponent<StackProps>("ZStack")
export const Grid = hostComponent<GridProps>("Grid")
export const GridRow = hostComponent<GridRowProps>("GridRow")
export const FlowLayout = hostComponent<FlowLayoutProps>("FlowLayout")
export const ScrollView = hostComponent<ScrollViewProps>("ScrollView")
export const WidthThreshold = hostComponent<WidthThresholdProps>("WidthThreshold")
export const List = hostComponent<ListProps>("List")
export const Section = hostComponent<SectionProps>("Section")
export const NavigationSplitView = hostComponent<NavigationSplitViewProps>("NavigationSplitView")
export const Spacer = hostComponent<SpacerProps>("Spacer")
export const Text = hostComponent<TextProps>("Text")
export const Label = hostComponent<LabelProps>("Label")
export const Image = hostComponent<ImageProps>("Image")
export const Divider = hostComponent<DividerProps>("Divider")
export const Button = hostComponent<ButtonProps>("Button")
