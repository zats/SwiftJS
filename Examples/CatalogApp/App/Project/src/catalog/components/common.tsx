import {
  Button,
  HStack,
  Image,
  Label,
  List,
  Menu,
  NavigationLink,
  NavigationStack,
  ScrollView,
  Section,
  Sheet,
  Spacer,
  Text,
  VStack,
  ZStack,
  useState,
  type ToolbarValue,
} from "swiftjs"
import type {
  CardProps,
  ChromePreviewProps,
  FixedTextProps,
  LinkVariantProps,
  ListPreviewProps,
  SectionProps,
  SheetLauncherProps,
  ShellProps,
} from "../shared"
import { space } from "../shared"

function ScreenShell(props: ShellProps) {
  return (
    <NavigationStack>
      <ScrollView
        navigationTitle={props.title}
        navigationBarTitleDisplayMode={props.displayMode ?? "large"}
        toolbar={props.toolbar}
        toolbarBackgroundVisibility={props.toolbarBackgroundVisibility}
        toolbarColorScheme={props.toolbarColorScheme}
        safeAreaInset={props.safeAreaInset as never}
        alert={props.alert}
        confirmationDialog={props.confirmationDialog as never}
        background="systemGroupedBackground"
      >
        <VStack alignment="leading" spacing={space.xxl} padding={space.lg}>
          {props.children}
        </VStack>
      </ScrollView>
    </NavigationStack>
  )
}

function DemoSection(props: SectionProps) {
  return (
    <VStack alignment="leading" spacing={space.md}>
      <VStack alignment="leading" spacing={space.xs}>
        <Text font="title3" fontWeight="semibold">
          {props.title}
        </Text>
        {props.detail ? <Text foregroundColor="secondary">{props.detail}</Text> : undefined}
      </VStack>
      <VStack alignment="leading" spacing={space.md}>
        {props.children}
      </VStack>
    </VStack>
  )
}

function Card(props: CardProps) {
  return (
    <VStack alignment="leading" spacing={space.sm} background="secondarySystemBackground" cornerRadius={20} padding={space.lg}>
      <VStack alignment="leading" spacing={space.xs}>
        <Text font="headline">{props.title}</Text>
        {props.detail ? <Text foregroundColor="secondary">{props.detail}</Text> : undefined}
      </VStack>
      {props.children}
    </VStack>
  )
}

function Pill(props: { text: string }) {
  return (
    <Text background="tertiarySystemBackground" cornerRadius={999} padding={space.sm} lineLimit={1} minimumScaleFactor={0.8}>
      {props.text}
    </Text>
  )
}

function ValuePlate(props: { title: string; detail: string }) {
  return (
    <VStack alignment="leading" spacing={space.xs} background="tertiarySystemBackground" cornerRadius={14} padding={space.md}>
      <Text font="headline">{props.title}</Text>
      <Text font="caption" foregroundColor="secondary">
        {props.detail}
      </Text>
    </VStack>
  )
}

function InsetBar(props: { title: string; detail: string; compact?: boolean }) {
  return (
    <HStack
      spacing={space.sm}
      background="tertiarySystemBackground"
      padding={props.compact ? space.sm : space.md}
      safeAreaPadding={{ edges: "horizontal", length: 16 }}
    >
      <Label title={props.title} systemName="dock.rectangle" />
      <Spacer />
      <Text font="caption" foregroundColor="secondary">
        {props.detail}
      </Text>
    </HStack>
  )
}

function LinkVariant(props: LinkVariantProps) {
  return (
    <NavigationLink
      navigationLinkIndicatorVisibility={props.indicator}
      destination={<ChromePreviewScreen title={props.title} displayMode="inline" toolbarBackgroundVisibility="visible" />}
    >
      <VStack alignment="leading" spacing={space.xxs}>
        <Text font="headline">{props.title}</Text>
        <Text font="caption" foregroundColor="secondary">
          {props.detail}
        </Text>
      </VStack>
    </NavigationLink>
  )
}

function ChromePreviewScreen(props: ChromePreviewProps) {
  return (
    <ScreenShell
      title={props.title}
      displayMode={props.displayMode}
      toolbarBackgroundVisibility={props.toolbarBackgroundVisibility}
      toolbarColorScheme={props.toolbarColorScheme}
      toolbar={[
        { placement: "topBarLeading", content: <Button action={() => undefined} buttonStyle="plain"><Image systemName="chevron.left" /></Button> },
        { placement: "principal", content: <Text font="headline">Chrome</Text> },
        { placement: "topBarTrailing", content: <Menu content={<Button action={() => undefined} buttonStyle="plain">Refresh</Button>}><Image systemName="ellipsis.circle" /></Menu> },
        { placement: "bottomBar", content: <Text font="caption">Bottom Bar</Text> },
      ]}
    >
      <Card title="Navigation Chrome">
        <Text>{`displayMode=${props.displayMode}, toolbarBackground=${props.toolbarBackgroundVisibility}${props.toolbarColorScheme ? `, colorScheme=${props.toolbarColorScheme}` : ""}`}</Text>
      </Card>
    </ScreenShell>
  )
}

function SheetLauncher(props: SheetLauncherProps) {
  const [isPresented, setIsPresented] = useState(false)

  return (
    <Sheet
      isPresented={isPresented}
      onDismiss={() => setIsPresented(false)}
      content={
        <NavigationStack>
          <ZStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} background="systemGroupedBackground" ignoresSafeArea>
            <ScrollView
              navigationTitle="Sheet"
              navigationBarTitleDisplayMode="inline"
              background="clear"
              toolbarBackgroundVisibility="hidden"
              toolbar={[
                {
                  placement: "topBarTrailing",
                  content: (
                    <Button action={() => setIsPresented(false)} buttonStyle="plain">
                      Done
                    </Button>
                  ),
                },
              ]}
            >
              <VStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} alignment="leading" spacing={space.lg} padding={space.lg}>
                <Card title={props.title}>
                  <Text>{`detents=${props.detents.length}, dragIndicator=${props.dragIndicator}`}</Text>
                  <Text>{`backgroundInteraction=${typeof props.backgroundInteraction === "string" ? props.backgroundInteraction : "upThrough"}`}</Text>
                  {props.interactiveDismissDisabled ? <Text foregroundColor="secondary">Interactive dismiss is disabled on this sheet.</Text> : undefined}
                </Card>
              </VStack>
            </ScrollView>
          </ZStack>
        </NavigationStack>
      }
      presentationDetents={props.detents}
      presentationDragIndicator={props.dragIndicator}
      presentationCornerRadius={32}
      presentationBackgroundInteraction={props.backgroundInteraction}
      interactiveDismissDisabled={props.interactiveDismissDisabled}
    >
      <Button action={() => setIsPresented(true)} buttonStyle="bordered">
        {props.title}
      </Button>
    </Sheet>
  )
}

function FullScreenDemo(props: { onClose: () => void }) {
  return (
    <NavigationStack>
      <ZStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} background="systemGroupedBackground" ignoresSafeArea>
        <ScrollView navigationTitle="Full Screen" navigationBarTitleDisplayMode="inline" background="clear" toolbarBackgroundVisibility="hidden">
          <VStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} alignment="leading" spacing={space.lg} padding={space.lg}>
            <Card title="FullScreenCover">
              <Text>This cover exercises the full-screen presentation path and interactiveDismissDisabled.</Text>
              <Button action={props.onClose} buttonStyle="borderedProminent">
                Close
              </Button>
            </Card>
          </VStack>
        </ScrollView>
      </ZStack>
    </NavigationStack>
  )
}

function TabBody(props: { label: string }) {
  return (
    <VStack alignment="leading" spacing={space.sm} padding={space.lg}>
      <Text font="headline">{props.label}</Text>
      <Text foregroundColor="secondary">Nested TabView exercises tab item title, SF Symbol, asset image, and badge handling.</Text>
    </VStack>
  )
}

function ListPreview(props: ListPreviewProps) {
  return (
    <VStack spacing={space.sm}>
      <Text font="headline">{props.title}</Text>
      <List
        frame={{ width: 280, height: 220 }}
        listStyle={props.style}
        scrollContentBackground={props.scrollContentBackground}
        listRowSeparator={props.listRowSeparator}
        listSectionSeparator={props.listSectionSeparator}
        listRowBackground={props.listRowBackground}
        listRowInsets={props.listRowInsets}
        contentMargins={props.contentMargins}
      >
        <Section title="Pinned">
          <Label title="Overview" systemName="star" />
          <Label title="Updates" systemName="clock" />
        </Section>
        <Section title="Library">
          <Label title="Downloads" systemName="arrow.down.circle" />
          <Label title="Favorites" systemName="heart" />
        </Section>
      </List>
    </VStack>
  )
}

function FixedText(props: FixedTextProps) {
  const content =
    props.fixedSize === true || (typeof props.fixedSize === "object" && props.fixedSize.horizontal)
      ? "Metrics stay intact."
      : "Ideal metrics stay intact when width tightens."

  return (
    <VStack spacing={space.xs} alignment="leading">
      <Text font="caption" foregroundColor="secondary" frame={{ width: 112 }}>
        {props.title}
      </Text>
      <HStack spacing={space.sm} frame={{ maxWidth: "infinity" }}>
        <Text fixedSize={props.fixedSize} background="tertiarySystemBackground" cornerRadius={10} padding={space.sm} frame={{ width: 168 }}>
          {content}
        </Text>
        <Spacer />
      </HStack>
    </VStack>
  )
}

function ToolbarPlacementsSheetLauncher(props: { title: string; summary: string; toolbar: ToolbarValue; navigationTitle?: string }) {
  const [isPresented, setIsPresented] = useState(false)

  return (
    <Sheet
      isPresented={isPresented}
      onDismiss={() => setIsPresented(false)}
      content={
        <NavigationStack>
          <ZStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} background="systemGroupedBackground" ignoresSafeArea>
            <ScrollView
              navigationTitle={props.navigationTitle ?? props.title}
              navigationBarTitleDisplayMode="inline"
              background="clear"
              toolbarBackgroundVisibility="hidden"
              toolbar={props.toolbar}
            >
              <VStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} alignment="leading" spacing={space.lg} padding={space.lg}>
                <Card title={props.title}>
                  <Text>{props.summary}</Text>
                </Card>
              </VStack>
            </ScrollView>
          </ZStack>
        </NavigationStack>
      }
    >
      <Button action={() => setIsPresented(true)} buttonStyle="bordered">
        {props.title}
      </Button>
    </Sheet>
  )
}

export {
  Card,
  ChromePreviewScreen,
  DemoSection,
  FixedText,
  FullScreenDemo,
  InsetBar,
  LinkVariant,
  ListPreview,
  Pill,
  ScreenShell,
  SheetLauncher,
  TabBody,
  ToolbarPlacementsSheetLauncher,
  ValuePlate,
}
