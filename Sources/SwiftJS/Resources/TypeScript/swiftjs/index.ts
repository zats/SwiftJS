import type {
  AlertValue,
  AngularGradientProps,
  AspectRatioValue,
  BadgeValue,
  ButtonProps,
  ConfirmationDialogValue,
  ContentUnavailableProps,
  ContentMarginsValue,
  ControlGroupProps,
  CapsuleProps,
  CircleProps,
  ColorSchemeValue,
  CustomValue,
  CustomLayoutProps,
  DialogActionRole,
  DialogActionValue,
  DividerProps,
  DisclosureGroupProps,
  EdgeInsetsValue,
  EdgeSetValue,
  EdgeValue,
  EllipseProps,
  FlowLayoutProps,
  FormProps,
  FullScreenCoverProps,
  IgnoresSafeAreaValue,
  GeometryReaderProps,
  GridProps,
  GridRowProps,
  ImageInterpolation,
  ImageProps,
  LabelProps,
  LayoutBounds,
  LayoutPlacement,
  LayoutSubview,
  LinearGradientProps,
  ListProps,
  MenuProps,
  NavigationLinkProps,
  NavigationBarTitleDisplayMode,
  NavigationSplitViewProps,
  NavigationStackProps,
  PickerProps,
  PresentationBackgroundInteractionValue,
  PresentationDetentValue,
  PresentationDragIndicator,
  ProposedViewSize,
  RadialGradientProps,
  RectangleProps,
  RoundedRectangleProps,
  SafeAreaInsetValue,
  SafeAreaPaddingValue,
  ScrollViewProps,
  SectionProps,
  SheetProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  TabProps,
  TabValue,
  TabViewProps,
  TextAlignmentValue,
  TextProps,
  ToggleProps,
  ToolbarItemPlacement,
  ToolbarItemValue,
  ToolbarValue,
  TruncationMode,
  VisibilityKind,
  ViewThatFitsProps,
} from "./types"

export type {
  AlertValue,
  AngularGradientProps,
  AngularGradientValue,
  AspectRatioValue,
  AxisValue,
  BadgeValue,
  ButtonBorderShape,
  ButtonProps,
  ButtonStyle,
  CapsuleProps,
  CircleProps,
  ColorValue,
  ColorSchemeValue,
  ContentAlignment,
  ContentMarginsValue,
  ContentMarginPlacement,
  ContentUnavailableProps,
  ControlGroupProps,
  DialogActionRole,
  DialogActionValue,
  CustomValue,
  CustomLayoutProps,
  DividerProps,
  DisclosureGroupProps,
  EdgeInsetsValue,
  EdgeSetValue,
  EdgeValue,
  EllipseProps,
  FlowLayoutProps,
  FontValue,
  FontWeight,
  FormProps,
  FrameValue,
  FullScreenCoverProps,
  GeometryProxy,
  GeometryReaderProps,
  GlassEffectValue,
  GradientStop,
  GridProps,
  GridRowProps,
  FixedSizeValue,
  IgnoresSafeAreaValue,
  ImageContentMode,
  ImageInterpolation,
  ImageProps,
  LabelProps,
  LayoutBounds,
  LayoutPlacement,
  LayoutSubview,
  LinearGradientProps,
  LinearGradientValue,
  ListProps,
  ListStyle,
  MenuProps,
  NavigationLinkProps,
  NavigationBarTitleDisplayMode,
  NavigationSplitViewProps,
  NavigationStackProps,
  PickerOption,
  PickerProps,
  PickerValue,
  PresentationBackgroundInteractionValue,
  PresentationDetentValue,
  PresentationDragIndicator,
  ProposedViewSize,
  RadialGradientProps,
  RadialGradientValue,
  RectangleProps,
  RoundedRectangleProps,
  SafeAreaInsetValue,
  SafeAreaPaddingValue,
  ScrollViewProps,
  SectionProps,
  ShapeProps,
  ShapeStyleValue,
  SheetProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  SymbolRenderingMode,
  TabProps,
  TabValue,
  TabViewProps,
  TextAlignmentValue,
  TextProps,
  ToggleProps,
  ToolbarItemPlacement,
  ToolbarItemValue,
  ToolbarValue,
  TruncationMode,
  UnitPointValue,
  Visibility,
  VisibilityKind,
  ViewProps,
  ViewThatFitsProps,
} from "./types"

export { EKEventStore } from "./calendar"
export type {
  EKAuthorizationStatus,
  EKCalendar,
  EKCalendarType,
  EKEvent,
  EKEventAvailability,
  EKEventInput,
  EKEventPredicate,
  EKEventStatus,
  EKSource,
  EKSourceType,
  EKSpan,
} from "./calendar"

export { CLLocationManager } from "./location"
export type { CLAccuracyAuthorization, CLAuthorizationStatus, CLLocation, CLLocationCoordinate2D } from "./location"

/** Values persisted by `useAppStorage`. */
export type AppStorageValue = string | number | boolean

/** Runtime bridge injected by SwiftJS into the JavaScript global scope. */
export type Runtime = {
  Fragment: symbol
  createElement: (type: unknown, props?: Record<string, unknown>, ...children: unknown[]) => unknown
  hasLayoutHandler: (id: string) => boolean
  invokeModule: <Response>(moduleName: string, methodName: string, payload?: unknown) => Promise<Response>
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
export const invokeModule = <Response,>(moduleName: string, methodName: string, payload?: unknown) =>
  runtime().invokeModule<Response>(moduleName, methodName, payload)
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
export const ViewThatFits = hostComponent<ViewThatFitsProps>("ViewThatFits")
export const CustomLayout = hostComponent<CustomLayoutProps>("CustomLayout")
export const ScrollView = hostComponent<ScrollViewProps>("ScrollView")
export const GeometryReader = hostComponent<GeometryReaderProps>("GeometryReader")
export const List = hostComponent<ListProps>("List")
export const Form = hostComponent<FormProps>("Form")
export const Section = hostComponent<SectionProps>("Section")
export const NavigationStack = hostComponent<NavigationStackProps>("NavigationStack")
export const NavigationLink = hostComponent<NavigationLinkProps>("NavigationLink")
export const Sheet = hostComponent<SheetProps>("Sheet")
export const FullScreenCover = hostComponent<FullScreenCoverProps>("FullScreenCover")
export const TabView = hostComponent<TabViewProps>("TabView")
export const Tab = hostComponent<TabProps>("Tab")
export const NavigationSplitView = hostComponent<NavigationSplitViewProps>("NavigationSplitView")
export const Spacer = hostComponent<SpacerProps>("Spacer")
export const Text = hostComponent<TextProps>("Text")
export const Label = hostComponent<LabelProps>("Label")
export const ContentUnavailableView = hostComponent<ContentUnavailableProps>("ContentUnavailableView")
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
export const Menu = hostComponent<MenuProps>("Menu")
export const DisclosureGroup = hostComponent<DisclosureGroupProps>("DisclosureGroup")
export const ControlGroup = hostComponent<ControlGroupProps>("ControlGroup")
export const Picker = hostComponent<PickerProps>("Picker")
export const Toggle = hostComponent<ToggleProps>("Toggle")
