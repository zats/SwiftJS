import type {
  AngularGradientProps,
  AspectRatioValue,
  ButtonProps,
  CapsuleProps,
  CircleProps,
  CustomValue,
  CustomLayoutProps,
  DividerProps,
  EllipseProps,
  FormProps,
  GeometryReaderProps,
  FlowLayoutProps,
  GridProps,
  GridRowProps,
  ImageInterpolation,
  ImageProps,
  LayoutBounds,
  LayoutPlacement,
  LayoutSubview,
  LabelProps,
  ListProps,
  LinearGradientProps,
  NavigationLinkProps,
  NavigationStackProps,
  NavigationSplitViewProps,
  ProposedViewSize,
  RectangleProps,
  RoundedRectangleProps,
  RadialGradientProps,
  ScrollViewProps,
  SectionProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  TextProps,
  ToggleProps,
  VisibilityKind,
} from "./types"

export type {
  AngularGradientProps,
  AngularGradientValue,
  AspectRatioValue,
  AxisValue,
  ButtonBorderShape,
  ButtonProps,
  ButtonStyle,
  CapsuleProps,
  CircleProps,
  ColorValue,
  ContentAlignment,
  CustomValue,
  CustomLayoutProps,
  DividerProps,
  EllipseProps,
  FormProps,
  GeometryProxy,
  GeometryReaderProps,
  GradientStop,
  FontValue,
  FontWeight,
  FlowLayoutProps,
  FrameValue,
  FixedSizeValue,
  GlassEffectValue,
  GridProps,
  GridRowProps,
  ImageInterpolation,
  ImageContentMode,
  ImageProps,
  LayoutBounds,
  LayoutPlacement,
  LayoutSubview,
  LabelProps,
  LinearGradientProps,
  LinearGradientValue,
  ListProps,
  ListStyle,
  NavigationLinkProps,
  NavigationStackProps,
  NavigationSplitViewProps,
  ProposedViewSize,
  RadialGradientProps,
  RadialGradientValue,
  RectangleProps,
  RoundedRectangleProps,
  ScrollViewProps,
  SectionProps,
  ShapeProps,
  ShapeStyleValue,
  SpacerProps,
  StackDistribution,
  StackProps,
  SymbolRenderingMode,
  TextProps,
  UnitPointValue,
  ToggleProps,
  VisibilityKind,
  ViewProps,
} from "./types"

/** Values persisted by `useAppStorage`. */
export type AppStorageValue = string | number | boolean

export type Runtime = {
  Fragment: symbol
  createElement: (type: unknown, props?: Record<string, unknown>, ...children: unknown[]) => unknown
  hasLayoutHandler: (id: string) => boolean
  measureLayout: (id: string, proposalJSON: string, subviewCount: number) => string
  mount: (component: () => unknown) => void
  placeLayoutSubviews: (id: string, boundsJSON: string, proposalJSON: string, subviewCount: number) => string
  /** Persists a primitive value through the native app storage bridge. */
  useAppStorage: <Value extends AppStorageValue>(
    key: string,
    defaultValue: Value
  ) => [Value, (nextValue: Value | ((current: Value) => Value)) => void]
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
/** Stores a string, number, or boolean in native app storage under `key`. */
export const useAppStorage = <Value extends AppStorageValue>(key: string, defaultValue: Value) =>
  runtime().useAppStorage(key, defaultValue)
export const useEffect = (effect: () => void | (() => void), deps?: unknown[]) => runtime().useEffect(effect, deps)
export const useRef = <Value,>(initialValue: Value) => runtime().useRef(initialValue)
export const mount = (component: () => unknown) => runtime().mount(component)

export const VStack = hostComponent<StackProps>("VStack")
export const HStack = hostComponent<StackProps>("HStack")
export const ZStack = hostComponent<StackProps>("ZStack")
export const Grid = hostComponent<GridProps>("Grid")
export const GridRow = hostComponent<GridRowProps>("GridRow")
export const FlowLayout = hostComponent<FlowLayoutProps>("FlowLayout")
export const CustomLayout = hostComponent<CustomLayoutProps>("CustomLayout")
export const ScrollView = hostComponent<ScrollViewProps>("ScrollView")
export const GeometryReader = hostComponent<GeometryReaderProps>("GeometryReader")
export const List = hostComponent<ListProps>("List")
export const Form = hostComponent<FormProps>("Form")
export const Section = hostComponent<SectionProps>("Section")
export const NavigationStack = hostComponent<NavigationStackProps>("NavigationStack")
export const NavigationLink = hostComponent<NavigationLinkProps>("NavigationLink")
export const NavigationSplitView = hostComponent<NavigationSplitViewProps>("NavigationSplitView")
export const Spacer = hostComponent<SpacerProps>("Spacer")
export const Text = hostComponent<TextProps>("Text")
export const Label = hostComponent<LabelProps>("Label")
export const Image = hostComponent<ImageProps>("Image")
export const Rectangle = hostComponent<RectangleProps>("Rectangle")
export const RoundedRectangle = hostComponent<RoundedRectangleProps>("RoundedRectangle")
export const Circle = hostComponent<CircleProps>("Circle")
export const Capsule = hostComponent<CapsuleProps>("Capsule")
export const Ellipse = hostComponent<EllipseProps>("Ellipse")
export const LinearGradient = hostComponent<LinearGradientProps>("LinearGradient")
export const RadialGradient = hostComponent<RadialGradientProps>("RadialGradient")
export const AngularGradient = hostComponent<AngularGradientProps>("AngularGradient")
export const Divider = hostComponent<DividerProps>("Divider")
export const Button = hostComponent<ButtonProps>("Button")
export const Toggle = hostComponent<ToggleProps>("Toggle")
