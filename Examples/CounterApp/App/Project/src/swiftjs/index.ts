import type {
  AngularGradientProps,
  ButtonProps,
  CapsuleProps,
  CircleProps,
  DividerProps,
  EllipseProps,
  ImageProps,
  LinearGradientProps,
  RadialGradientProps,
  RectangleProps,
  RoundedRectangleProps,
  StackProps,
  TextProps,
} from "./types"

export type {
  AngularGradientProps,
  AngularGradientValue,
  ButtonBorderShape,
  ButtonProps,
  ButtonStyle,
  CapsuleProps,
  CircleProps,
  ColorValue,
  ContentAlignment,
  DividerProps,
  EllipseProps,
  FontValue,
  FontWeight,
  FrameValue,
  GlassEffectValue,
  GradientStop,
  ImageProps,
  LinearGradientProps,
  LinearGradientValue,
  RadialGradientProps,
  RadialGradientValue,
  RectangleProps,
  RoundedRectangleProps,
  ShapeProps,
  ShapeStyleValue,
  StackProps,
  SymbolRenderingMode,
  TextProps,
  UnitPointValue,
  VisibilityKind,
  ViewProps,
} from "./types"

/** Values persisted by `useAppStorage`. */
export type AppStorageValue = string | number | boolean

export type Runtime = {
  Fragment: symbol
  createElement: (type: unknown, props?: Record<string, unknown>, ...children: unknown[]) => unknown
  mount: (component: () => unknown) => void
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
    return runtime().createElement(name, props)
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
export const Text = hostComponent<TextProps>("Text")
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
