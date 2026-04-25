import type {
  AlertValue,
  AngularGradientProps,
  AsyncImageProps,
  AspectRatioValue,
  BadgeValue,
  ButtonRole,
  ButtonProps,
  ConfirmationDialogValue,
  ContextMenuValue,
  ContentUnavailableProps,
  ContentMarginsValue,
  ControlGroupProps,
  CapsuleProps,
  CircleProps,
  ColorSchemeValue,
  CustomValue,
  CustomProps,
  CustomLayoutProps,
  DatePickerDisplayedComponents,
  DatePickerProps,
  DatePickerRange,
  DateValue,
  DialogActionRole,
  DialogActionValue,
  DividerProps,
  DropDestinationValue,
  DropLocationValue,
  DroppedTransferItemValue,
  DisclosureGroupProps,
  EditButtonProps,
  EditMode,
  EdgeInsetsValue,
  EdgeSetValue,
  EdgeValue,
  EllipseProps,
  FlowLayoutProps,
  ForEachProps,
  FormProps,
  FullScreenCoverProps,
  IgnoresSafeAreaValue,
  GeometryReaderProps,
  GridProps,
  GridRowProps,
  GroupBoxProps,
  ImageInterpolation,
  ImageProps,
  LabelProps,
  KeyboardType,
  LayoutBounds,
  LayoutPlacement,
  LayoutSubview,
  LinkProps,
  LinearGradientProps,
  ListProps,
  ListSelectionValue,
  MenuProps,
  MoveAction,
  NavigationLinkProps,
  NavigationBarTitleDisplayMode,
  NavigationSplitViewProps,
  NavigationStackProps,
  NumericRangeValue,
  PickerProps,
  ProgressViewProps,
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
  SecureFieldProps,
  SectionProps,
  SensoryFeedbackKind,
  SensoryFeedbackValue,
  ShareLinkProps,
  ShareItemValue,
  SheetProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  SliderProps,
  StepperProps,
  SubmitLabel,
  TabProps,
  TabBarMinimizeBehavior,
  TabRole,
  TabValue,
  TabViewBottomAccessoryValue,
  TabViewProps,
  TextAlignmentValue,
  TextInputAutocapitalization,
  TextEditorProps,
  TextFieldProps,
  TextProps,
  TransferItemValue,
  ToggleProps,
  ToolbarItemPlacement,
  ToolbarItemValue,
  ToolbarSpacerSizing,
  ToolbarValue,
  TruncationMode,
  VisibilityKind,
  ViewThatFitsProps,
  WebViewProps,
} from "./types"

export type {
  AlertValue,
  AngularGradientProps,
  AngularGradientValue,
  AsyncImageProps,
  AspectRatioValue,
  AxisValue,
  BadgeValue,
  ButtonRole,
  ButtonBorderShape,
  ButtonProps,
  ButtonStyle,
  CapsuleProps,
  CircleProps,
  ColorValue,
  HexColorValue,
  NamedColorValue,
  ColorSchemeValue,
  ContentAlignment,
  ContentMarginsValue,
  ContentMarginPlacement,
  ContentUnavailableProps,
  ContextMenuValue,
  ControlGroupProps,
  CustomProps,
  DialogActionRole,
  DialogActionValue,
  CustomValue,
  CustomLayoutProps,
  DatePickerDisplayedComponents,
  DatePickerProps,
  DatePickerRange,
  DateValue,
  DividerProps,
  DropDestinationValue,
  DropLocationValue,
  DroppedTransferItemValue,
  DisclosureGroupProps,
  EditButtonProps,
  EditMode,
  EdgeInsetsValue,
  EdgeSetValue,
  EdgeValue,
  EllipseProps,
  FlowLayoutProps,
  ForEachProps,
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
  GroupBoxProps,
  FixedSizeValue,
  HorizontalEdgeValue,
  IgnoresSafeAreaValue,
  ImageContentMode,
  ImageInterpolation,
  ImageProps,
  LabelProps,
  KeyboardType,
  LayoutBounds,
  LayoutPlacement,
  LayoutSubview,
  LinkProps,
  LinearGradientProps,
  LinearGradientValue,
  ListProps,
  ListStyle,
  ListSelectionValue,
  MenuProps,
  MoveAction,
  NavigationLinkProps,
  NavigationBarTitleDisplayMode,
  NavigationSplitViewProps,
  NavigationStackProps,
  NumericRangeValue,
  PickerOption,
  PickerProps,
  PickerStyle,
  PickerValue,
  ProgressViewProps,
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
  SearchableValue,
  SecureFieldProps,
  SectionProps,
  SensoryFeedbackKind,
  SensoryFeedbackValue,
  ShareLinkProps,
  ShareItemValue,
  ShapeProps,
  ShapeStyleValue,
  SheetProps,
  SpacerProps,
  StackDistribution,
  StackProps,
  SliderProps,
  StepperProps,
  SubmitLabel,
  SwipeActionsEntry,
  SwipeActionsValue,
  SymbolRenderingMode,
  TabProps,
  TabBarMinimizeBehavior,
  TabRole,
  TabValue,
  TabViewBottomAccessoryValue,
  TabViewProps,
  TextAlignmentValue,
  TextInputAutocapitalization,
  TextEditorProps,
  TextFieldProps,
  TextProps,
  TransferItemValue,
  ToggleProps,
  ToolbarItemPlacement,
  ToolbarItemValue,
  ToolbarSpacerSizing,
  ToolbarValue,
  TruncationMode,
  UnitPointValue,
  Visibility,
  VisibilityKind,
  ViewProps,
  ViewThatFitsProps,
  WebViewProps,
} from "./types"

/** Values persisted by `useAppStorage`. */
export type AppStorageValue = string | number | boolean

export type {
  SearchFieldNavigationBarDrawerDisplayMode,
  SearchFieldPlacement,
  SearchPresentationToolbarBehavior,
  SearchToolbarBehavior,
  ToolbarRole,
} from "./types"

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

function normalizeDateValue(value: DateValue, label: string) {
  if (value instanceof Date) {
    if (Number.isNaN(value.getTime())) {
      throw new Error(label + " must be a valid Date")
    }

    return value.toISOString()
  }

  if (typeof value === "string" && value.length > 0) {
    return value
  }

  throw new Error(label + " must be a Date or non-empty ISO 8601 string")
}

function normalizeDateRange<Value extends DateValue>(range: DatePickerRange<Value> | undefined) {
  return {
    minimumDate: range?.start === undefined ? undefined : normalizeDateValue(range.start, "DatePicker range start"),
    maximumDate: range?.end === undefined ? undefined : normalizeDateValue(range.end, "DatePicker range end"),
  }
}

function restoreDateValue<Value extends DateValue>(value: string, template: Value) {
  if (typeof template !== "string" && template instanceof Date) {
    const parsed = new Date(value)
    if (Number.isNaN(parsed.getTime())) {
      throw new Error("DatePicker emitted an invalid ISO 8601 value")
    }

    return parsed as Value
  }

  return value as Value
}

export const Fragment = runtime().Fragment
export const createElement = (type: unknown, props?: Record<string, unknown>, ...children: unknown[]) =>
  runtime().createElement(type, props, ...children)
/** Calls a native SwiftJS module method and resolves the decoded JSON response. */
export const invokeModule = <Response,>(moduleName: string, methodName: string, payload?: unknown) =>
  runtime().invokeModule<Response>(moduleName, methodName, payload)
/**
 * React-style state hook backed by the SwiftJS runtime.
 *
 * const [count, setCount] = useState(0)
 */
export const useState = <Value,>(initialValue: Value | (() => Value)) => runtime().useState(initialValue)
/**
 * Stores a string, number, or boolean in native app storage under `key`.
 *
 * const [tab, setTab] = useAppStorage("selectedTab", "home")
 */
export const useAppStorage = <Value extends AppStorageValue>(key: string, defaultValue: Value) =>
  runtime().useAppStorage(key, defaultValue)
/** Registers an effect that reruns when `deps` changes. */
export const useEffect = (effect: () => void | (() => void), deps?: unknown[]) => runtime().useEffect(effect, deps)
/** Returns a mutable ref object that survives rerenders. */
export const useRef = <Value,>(initialValue: Value) => runtime().useRef(initialValue)
/** Mounts a root component into the current SwiftJS surface. */
export const mount = (component: () => unknown) => runtime().mount(component)

/**
 * Arranges children vertically with optional spacing, alignment, and distribution.
 *
 * <VStack spacing={12} padding={16} alignment="leading">
 *   <Text font="headline">Workspace</Text>
 *   <Text foregroundColor="secondary">3 tasks due today</Text>
 *   <Button action={() => openInbox()} buttonStyle="borderedProminent">
 *     Review Tasks
 *   </Button>
 * </VStack>
 */
export const VStack = hostComponent<StackProps>("VStack")
/**
 * Arranges children horizontally with optional spacing, alignment, and distribution.
 *
 * <HStack spacing={12} padding={16}>
 *   <Label title="Storage" systemName="internaldrive" />
 *   <Spacer />
 *   <Text font="headline">84 GB</Text>
 * </HStack>
 */
export const HStack = hostComponent<StackProps>("HStack")
/**
 * Overlays children in the same bounds.
 *
 * <ZStack alignment="bottomTrailing">
 *   <Image name="mountains" frame={{ height: 180 }} imageContentMode="fill" />
 *   <Text background="black" foregroundColor="white" padding={8} cornerRadius={4}>
 *     Featured
 *   </Text>
 * </ZStack>
 */
export const ZStack = hostComponent<StackProps>("ZStack")
/**
 * Places children in rows and columns.
 *
 * <Grid horizontalSpacing={12} verticalSpacing={12}>
 *   <GridRow>
 *     <VStack padding={12} background="secondarySystemBackground" cornerRadius={12}>
 *       <Text font="caption">Revenue</Text>
 *       <Text font="headline">$24.8K</Text>
 *     </VStack>
 *     <VStack padding={12} background="secondarySystemBackground" cornerRadius={12}>
 *       <Text font="caption">Orders</Text>
 *       <Text font="headline">312</Text>
 *     </VStack>
 *   </GridRow>
 *   <GridRow>
 *     <VStack padding={12} background="secondarySystemBackground" cornerRadius={12}>
 *       <Text font="caption">Refunds</Text>
 *       <Text font="headline">8</Text>
 *     </VStack>
 *     <VStack padding={12} background="secondarySystemBackground" cornerRadius={12}>
 *       <Text font="caption">Conversion</Text>
 *       <Text font="headline">4.2%</Text>
 *     </VStack>
 *   </GridRow>
 * </Grid>
 */
export const Grid = hostComponent<GridProps>("Grid")
/**
 * Defines one row inside `Grid`.
 *
 * <Grid>
 *   <GridRow>
 *     <Text font="headline">Name</Text>
 *     <Text font="headline">Status</Text>
 *   </GridRow>
 * </Grid>
 */
export const GridRow = hostComponent<GridRowProps>("GridRow")
/**
 * Lays out children in wrapped lines.
 *
 * <FlowLayout spacing={8} lineSpacing={8}>
 *   <Text background="secondarySystemBackground" padding={8} cornerRadius={4}>Unread</Text>
 *   <Text background="secondarySystemBackground" padding={8} cornerRadius={4}>Assigned to Me</Text>
 *   <Text background="secondarySystemBackground" padding={8} cornerRadius={4}>Due Today</Text>
 *   <Text background="secondarySystemBackground" padding={8} cornerRadius={4}>Flagged</Text>
 * </FlowLayout>
 */
export const FlowLayout = hostComponent<FlowLayoutProps>("FlowLayout")
/**
 * Renders the first child that fits the proposed size.
 *
 * <ViewThatFits>
 *   <HStack spacing={12}>
 *     <Text lineLimit={1}>Quarterly performance summary</Text>
 *     <Button action={() => share()} buttonStyle="bordered">Share</Button>
 *   </HStack>
 *   <VStack alignment="leading" spacing={8}>
 *     <Text>Quarterly performance summary</Text>
 *     <Button action={() => share()} buttonStyle="bordered">Share</Button>
 *   </VStack>
 * </ViewThatFits>
 */
export const ViewThatFits = hostComponent<ViewThatFitsProps>("ViewThatFits")
/**
 * Renders a named native custom host with JSON values and named slots.
 *
 * <Custom
 *   name="Card"
 *   values={{ emphasized: true }}
 *   slots={{ accessory: <Text>New</Text> }}
 * >
 *   <Text>Inbox</Text>
 * </Custom>
 */
export const Custom = hostComponent<CustomProps>("Custom")
/**
 * Delegates measurement and placement to a named JS layout.
 *
 * <CustomLayout name="Waterfall" values={{ columns: 2, spacing: 12 }}>
 *   <RoundedRectangle cornerRadius={12} fill="mint" frame={{ height: 160 }} />
 *   <RoundedRectangle cornerRadius={12} fill="blue" frame={{ height: 120 }} />
 *   <RoundedRectangle cornerRadius={12} fill="orange" frame={{ height: 180 }} />
 * </CustomLayout>
 */
export const CustomLayout = hostComponent<CustomLayoutProps>("CustomLayout")
/**
 * Adds vertical or horizontal scrolling around its content.
 *
 * <ScrollView padding={16}>
 *   <VStack spacing={16}>
 *     <Text font="headline">Latest Updates</Text>
 *     <RoundedRectangle cornerRadius={12} fill="secondarySystemBackground" frame={{ height: 120 }} />
 *     <RoundedRectangle cornerRadius={12} fill="secondarySystemBackground" frame={{ height: 120 }} />
 *     <RoundedRectangle cornerRadius={12} fill="secondarySystemBackground" frame={{ height: 120 }} />
 *   </VStack>
 * </ScrollView>
 */
export const ScrollView = hostComponent<ScrollViewProps>("ScrollView")
/**
 * Passes container geometry into a render closure.
 *
 * <GeometryReader>
 *   {(proxy) => (
 *     <Text font="headline">
 *       {proxy.size.width > 320 ? "Regular width" : "Compact width"}
 *     </Text>
 *   )}
 * </GeometryReader>
 */
export const GeometryReader = hostComponent<GeometryReaderProps>("GeometryReader")
/**
 * Renders rows using platform list chrome.
 *
 * <List
 *   listStyle="insetGrouped"
 *   searchable={{ text: query, onChange: setQuery, prompt: "Search" }}
 *   searchSuggestions={<Text searchCompletion="Ada">Ada</Text>}
 *   searchScopes={{ selection: scope, onChange: setScope, content: [<Text tag="all">All</Text>, <Text tag="people">People</Text>] }}
 * >
 *   <Section title="Pinned">
 *     <NavigationLink destination={<Text>Engineering room</Text>}>
 *       <Label title="Engineering" systemName="bubble.left.and.bubble.right" />
 *     </NavigationLink>
 *   </Section>
 * </List>
 */
export const List = hostComponent<ListProps>("List")
/**
 * Renders grouped rows using platform form chrome.
 *
 * <Form>
 *   <Section title="Profile">
 *     <Text>Ada Lovelace</Text>
 *     <Toggle isOn={publicProfile} onChange={setPublicProfile}>
 *       Public Profile
 *     </Toggle>
 *   </Section>
 * </Form>
 */
export const Form = hostComponent<FormProps>("Form")
/**
 * Groups repeated rows and carries move handling, mirroring SwiftUI's `ForEach` role in editable lists.
 *
 * <List selection={selectedIDs} onSelectionChange={setSelectedIDs}>
 *   <ForEach onMove={handleMove}>
 *     {rows}
 *   </ForEach>
 * </List>
 */
export const ForEach = hostComponent<ForEachProps>("ForEach")
/**
 * Groups list or form content under an optional header and footer.
 * `title` remains shorthand for a text header when `header` is omitted.
 *
 * <Section title="Notifications">
 *   <Toggle isOn={mentionsOnly} onChange={setMentionsOnly}>
 *     Mentions Only
 *   </Toggle>
 * </Section>
 */
export const Section = hostComponent<SectionProps>("Section")
/**
 * Provides stack-based navigation and navigation bar chrome.
 *
 * <NavigationStack
 *   navigationTitle="Library"
 *   path={path}
 *   onPathChange={setPath}
 *   navigationDestination={(value) => <Text>{String(value)}</Text>}
 * >
 *   <List>
 *     <NavigationLink value="detail">
 *       <Text>Open</Text>
 *     </NavigationLink>
 *   </List>
 * </NavigationStack>
 */
export const NavigationStack = hostComponent<NavigationStackProps>("NavigationStack")
/**
 * Triggers navigation to a destination view.
 *
 * <NavigationLink
 *   value="operations"
 *   navigationLinkIndicatorVisibility="visible"
 * >
 *   <Label title="Operations" systemName="tray.full" />
 * </NavigationLink>
 */
export const NavigationLink = hostComponent<NavigationLinkProps>("NavigationLink")
/**
 * Opens an external URL.
 *
 * <Link destination="https://www.apple.com">
 *   <Label title="Apple" systemName="safari" />
 * </Link>
 */
export const Link = hostComponent<LinkProps>("Link")
/**
 * SwiftJS-specific primitive for embedding web content.
 * This is not a SwiftUI-parity control.
 *
 * <WebView url="https://example.com" />
 */
export const WebView = hostComponent<WebViewProps>("WebView")
/**
 * Presents content in a modal sheet.
 *
 * <Sheet
 *   isPresented={showComposer}
 *   onDismiss={() => setShowComposer(false)}
 *   presentationDetents={["medium", "large"]}
 *   presentationDragIndicator="visible"
 *   content={<NavigationStack navigationTitle="Compose"><Text>Draft message</Text></NavigationStack>}
 * />
 */
export const Sheet = hostComponent<SheetProps>("Sheet")
/**
 * Presents content modally over the full screen.
 *
 * <FullScreenCover
 *   isPresented={showOnboarding}
 *   onDismiss={() => setShowOnboarding(false)}
 *   content={<ZStack><LinearGradient colors={["indigo", "blue"]} startPoint="top" endPoint="bottom" /><Text foregroundColor="white">Welcome</Text></ZStack>}
 * />
 */
export const FullScreenCover = hostComponent<FullScreenCoverProps>("FullScreenCover")
/**
 * Switches between child tabs.
 *
 * <TabView selection={tab} onSelectionChange={(next) => setTab(String(next))}>
 *   <Tab title="Home" value="home" systemName="house">
 *     <Text>Home</Text>
 *   </Tab>
 *   <Tab title="Inbox" value="inbox" systemName="tray" badge={3}>
 *     <Text>Inbox</Text>
 *   </Tab>
 * </TabView>
 */
export const TabView = hostComponent<TabViewProps>("TabView")
/**
 * Defines one tab inside `TabView`.
 *
 * <Tab title="Files" value="files" systemName="folder" badge="New">
 *   <Text>Files</Text>
 * </Tab>
 */
export const Tab = hostComponent<TabProps>("Tab")
/**
 * Presents sidebar and detail content together.
 *
 * <NavigationSplitView
 *   sidebar={
 *     <List>
 *       <Text>Projects</Text>
 *     </List>
 *   }
 *   detail={<Text>Choose a project</Text>}
 * />
 */
export const NavigationSplitView = hostComponent<NavigationSplitViewProps>("NavigationSplitView")
/**
 * Consumes flexible space inside stacks.
 *
 * <HStack>
 *   <Text>Downloads</Text>
 *   <Spacer />
 *   <Text foregroundColor="secondary">Paused</Text>
 * </HStack>
 */
export const Spacer = hostComponent<SpacerProps>("Spacer")
/**
 * Displays styled text.
 *
 * <Text
 *   font="headline"
 *   lineLimit={2}
 *   truncationMode="tail"
 *   minimumScaleFactor={0.9}
 * >
 *   Design review notes for the Q3 planning session
 * </Text>
 */
export const Text = hostComponent<TextProps>("Text")
/**
 * Displays text with an optional symbol or image.
 *
 * <Label title="Private Channel" systemName="lock.fill" font="headline" />
 */
export const Label = hostComponent<LabelProps>("Label")
/**
 * Displays an unavailable or empty state with optional description and actions.
 *
 * <ContentUnavailableView
 *   title="No Results"
 *   systemName="magnifyingglass"
 *   description={<Text>Try a broader term or clear filters.</Text>}
 * >
 *   <Button action={() => undefined} buttonStyle="borderedProminent">
 *     Clear Filters
 *   </Button>
 * </ContentUnavailableView>
 */
const ContentUnavailableViewBase = hostComponent<ContentUnavailableProps>("ContentUnavailableView")
export const ContentUnavailableView: typeof ContentUnavailableViewBase & { search: (text: string) => unknown } =
  Object.assign(ContentUnavailableViewBase, {
    search(text: string) {
      const query = text.trim()
      return createElement(ContentUnavailableViewBase, {
        title: query.length === 0 ? "No Results" : `No Results for "${text}"`,
        systemName: "magnifyingglass",
      })
    },
  })
/**
 * Displays indeterminate or determinate progress with optional labels.
 *
 * <ProgressView
 *   value={0.42}
 *   total={1}
 *   label={<Text>Syncing Files</Text>}
 *   currentValueLabel={<Text>42%</Text>}
 * />
 */
export const ProgressView = hostComponent<ProgressViewProps>("ProgressView")
/**
 * Displays an SF Symbol or asset image.
 *
 * <Image
 *   systemName="calendar"
 *   font={{ system: { size: 28, weight: "semibold" } }}
 *   tint="blue"
 * />
 */
export const Image = hostComponent<ImageProps>("Image")
/**
 * Loads and displays a remote image using native SwiftUI `AsyncImage`.
 *
 * <AsyncImage url={profile.photoURL} imageContentMode="fill" />
 */
export const AsyncImage = hostComponent<AsyncImageProps>("AsyncImage")
/**
 * Draws a rectangular fill or stroke.
 *
 * <Rectangle fill="quaternarySystemFill" frame={{ height: 1, maxWidth: "infinity" }} />
 */
export const Rectangle = hostComponent<RectangleProps>("Rectangle")
/**
 * Draws a rounded rectangular fill or stroke.
 *
 * <RoundedRectangle
 *   cornerRadius={12}
 *   fill="secondarySystemBackground"
 *   stroke="separator"
 *   frame={{ height: 88, maxWidth: "infinity" }}
 * />
 */
export const RoundedRectangle = hostComponent<RoundedRectangleProps>("RoundedRectangle")
/**
 * Draws a circular fill or stroke.
 *
 * <ZStack>
 *   <Circle fill="mint" frame={{ width: 44, height: 44 }} />
 *   <Text font="headline">AL</Text>
 * </ZStack>
 */
export const Circle = hostComponent<CircleProps>("Circle")
/**
 * Draws a capsule-shaped fill or stroke.
 *
 * <ZStack>
 *   <Capsule fill="green" frame={{ width: 72, height: 28 }} />
 *   <Text font="caption" foregroundColor="white">Live</Text>
 * </ZStack>
 */
export const Capsule = hostComponent<CapsuleProps>("Capsule")
/**
 * Draws an elliptical fill or stroke.
 *
 * <ZStack>
 *   <Ellipse fill="tertiarySystemFill" frame={{ width: 180, height: 96 }} />
 *   <Text font="headline">Focus Mode</Text>
 * </ZStack>
 */
export const Ellipse = hostComponent<EllipseProps>("Ellipse")
/**
 * Interpolates colors along a line.
 *
 * <LinearGradient
 *   colors={["indigo", "blue"]}
 *   startPoint="topLeading"
 *   endPoint="bottomTrailing"
 *   frame={{ height: 140, maxWidth: "infinity" }}
 * />
 */
export const LinearGradient = hostComponent<LinearGradientProps>("LinearGradient")
/**
 * Interpolates colors outward from a center point.
 *
 * <RadialGradient
 *   colors={["white", "blue"]}
 *   center="center"
 *   endRadius={120}
 *   frame={{ width: 180, height: 180 }}
 * />
 */
export const RadialGradient = hostComponent<RadialGradientProps>("RadialGradient")
/**
 * Interpolates colors around a center point.
 *
 * <AngularGradient
 *   colors={["pink", "orange", "yellow", "pink"]}
 *   center="center"
 *   frame={{ width: 180, height: 180 }}
 * />
 */
export const AngularGradient = hostComponent<AngularGradientProps>("AngularGradient")
/**
 * Draws a platform separator between adjacent content.
 *
 * <VStack spacing={12}>
 *   <Text>Billing</Text>
 *   <Divider />
 *   <Text>Invoices</Text>
 * </VStack>
 */
export const Divider = hostComponent<DividerProps>("Divider")
/**
 * Runs an action when activated.
 *
 * <Button action={() => saveChanges()} buttonStyle="borderedProminent">
 *   Save Changes
 * </Button>
 *
 * <Button action={() => deleteItem()} role="destructive">
 *   Delete
 * </Button>
 */
export const Button = hostComponent<ButtonProps>("Button")
/**
 * Toggles the nearest bound `editMode` environment.
 *
 * <NavigationStack editMode={editMode} onEditModeChange={setEditMode}>
 *   <EditButton />
 *   <List selection={selectedIDs} onSelectionChange={setSelectedIDs}>
 *     <Text tag="draft">Draft</Text>
 *   </List>
 * </NavigationStack>
 */
export const EditButton = hostComponent<EditButtonProps>("EditButton")
/**
 * Presents the system share sheet for text or URLs.
 *
 * <ShareLink
 *   item={{ kind: "url", value: "https://example.com/report" }}
 *   subject="Quarterly Report"
 * >
 *   <Label title="Share" systemName="square.and.arrow.up" />
 * </ShareLink>
 */
export const ShareLink = hostComponent<ShareLinkProps>("ShareLink")
/**
 * Binds editable plain text to a single-line field.
 *
 * <TextField title="Email" text={email} onChange={setEmail} prompt="name@example.com" />
 */
export const TextField = hostComponent<TextFieldProps>("TextField")
/**
 * Binds editable plain text to a secure single-line field.
 *
 * <SecureField title="Password" text={password} onChange={setPassword} />
 */
export const SecureField = hostComponent<SecureFieldProps>("SecureField")
/**
 * Binds editable plain text to a multiline editor.
 *
 * <TextEditor text={notes} onChange={setNotes} frame={{ minHeight: 160 }} />
 */
export const TextEditor = hostComponent<TextEditorProps>("TextEditor")
/**
 * Presents secondary actions from a trigger view.
 *
 * <Menu
 *   content={
 *     <VStack>
 *       <Button action={() => setSort("recent")} buttonStyle="plain">Sort by Recent</Button>
 *       <Button action={() => setSort("priority")} buttonStyle="plain">Sort by Priority</Button>
 *       <Button action={() => archiveDone()} buttonStyle="plain">Archive Completed</Button>
 *     </VStack>
 *   }
 * >
 *   <Label title="Sort" systemName="arrow.up.arrow.down" />
 * </Menu>
 */
export const Menu = hostComponent<MenuProps>("Menu")
/**
 * Shows collapsible content controlled by expanded state.
 *
 * <DisclosureGroup
 *   isExpanded={showAdvanced}
 *   onExpandedChange={setShowAdvanced}
 *   content={
 *     <VStack alignment="leading" spacing={12}>
 *       <Toggle isOn={includeArchived} onChange={setIncludeArchived}>Include Archived</Toggle>
 *       <Toggle isOn={mentionsOnly} onChange={setMentionsOnly}>Mentions Only</Toggle>
 *     </VStack>
 *   }
 * >
 *   Advanced Filters
 * </DisclosureGroup>
 */
export const DisclosureGroup = hostComponent<DisclosureGroupProps>("DisclosureGroup")
/**
 * Applies grouped control styling to child controls.
 *
 * <ControlGroup>
 *   <Button action={() => zoomOut()} buttonStyle="bordered">-</Button>
 *   <Button action={() => resetZoom()} buttonStyle="bordered">100%</Button>
 *   <Button action={() => zoomIn()} buttonStyle="bordered">+</Button>
 * </ControlGroup>
 */
export const ControlGroup = hostComponent<ControlGroupProps>("ControlGroup")
/**
 * Groups related content in a native SwiftUI container.
 *
 * <GroupBox title="Storage">
 *   <Text>84 GB available</Text>
 * </GroupBox>
 */
export const GroupBox = hostComponent<GroupBoxProps>("GroupBox")
/**
 * Binds one selected value to an option list.
 *
 * <Picker
 *   selection={sort}
 *   onChange={setSort}
 *   options={[
 *     { title: "Priority", value: "priority" },
 *     { title: "Recent", value: "recent" },
 *     { title: "Name", value: "name" },
 *   ]}
 * >
 *   <Label title="Sort Order" systemName="arrow.up.arrow.down" />
 * </Picker>
 */
export const Picker = hostComponent<PickerProps>("Picker")
/**
 * Binds a numeric value to a native range slider.
 *
 * <Slider value={volume} onChange={setVolume} range={{ start: 0, end: 1 }} />
 */
export const Slider = hostComponent<SliderProps>("Slider")
/**
 * Binds a numeric value to a native stepper.
 *
 * <Stepper value={guests} onChange={setGuests} range={{ start: 1, end: 12 }} step={1}>
 *   Guests: {guests}
 * </Stepper>
 */
export const Stepper = hostComponent<StepperProps>("Stepper")
const DatePickerBase = hostComponent<
  Omit<DatePickerProps<string>, "onChange" | "range"> & {
    minimumDate?: string
    maximumDate?: string
    onChange: (nextValue: string) => void
  }
>("DatePicker")
/**
 * Binds a date or time selection to native `DatePicker` controls.
 *
 * <DatePicker
 *   selection={start}
 *   onChange={setStart}
 *   displayedComponents="dateAndTime"
 *   range={{ start: new Date() }}
 * >
 *   <Label title="Start" systemName="calendar" />
 * </DatePicker>
 */
export function DatePicker<Value extends DateValue>(props: DatePickerProps<Value>) {
  const { selection, onChange, range, ...rest } = props
  const { minimumDate, maximumDate } = normalizeDateRange(range)

  return createElement(DatePickerBase, {
    ...rest,
    selection: normalizeDateValue(selection, "DatePicker selection"),
    minimumDate,
    maximumDate,
    onChange(nextValue: string) {
      onChange(restoreDateValue(nextValue, selection))
    },
  })
}
/**
 * Binds a boolean value to an on/off control.
 *
 * <Toggle isOn={notificationsEnabled} onChange={setNotificationsEnabled} tint="green">
 *   Push Notifications
 * </Toggle>
 */
export const Toggle = hostComponent<ToggleProps>("Toggle")
