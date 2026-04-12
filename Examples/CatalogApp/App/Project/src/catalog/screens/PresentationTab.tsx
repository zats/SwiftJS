import {
  Button,
  FullScreenCover,
  HStack,
  Image,
  Label,
  NavigationLink,
  Tab,
  TabView,
  Text,
  VStack,
  useState,
  type AlertValue,
} from "../../swiftjs"
import {
  Card,
  ChromePreviewScreen,
  DemoSection,
  FullScreenDemo,
  LinkVariant,
  ScreenShell,
  SheetLauncher,
  TabBody,
  ToolbarPlacementsSheetLauncher,
} from "../components/common"
import { space } from "../shared"
import { presentationToolbar } from "../toolbars"

export function PresentationTab() {
  const [full, setFull] = useState(false)
  const [showAlert, setShowAlert] = useState(false)
  const [showDialog, setShowDialog] = useState(false)

  const alert: AlertValue = {
    title: "Archive Draft?",
    isPresented: showAlert,
    message: <Text>Alerts render the title, message, and action roles through the JS tree.</Text>,
    actions: [
      { title: "Cancel", role: "cancel", action: () => setShowAlert(false) },
      { title: "Archive", role: "destructive", action: () => setShowAlert(false) },
    ],
  }

  return (
    <ScreenShell
      title="Presentation"
      toolbar={presentationToolbar}
      toolbarBackgroundVisibility="automatic"
      alert={alert}
      confirmationDialog={{
        title: "Choose Action",
        isPresented: showDialog,
        titleVisibility: "visible",
        message: <Text>ConfirmationDialog supports message content and action roles.</Text>,
        actions: [
          { title: "Favorite", action: () => setShowDialog(false) },
          { title: "Delete", role: "destructive", action: () => setShowDialog(false) },
          { title: "Cancel", role: "cancel", action: () => setShowDialog(false) },
        ],
      }}
    >
      <DemoSection title="Navigation" detail="NavigationStack, NavigationLink, link indicator visibility, and chrome variants.">
        <Card title="NavigationLink Variants">
          <VStack spacing={space.sm} alignment="leading">
            <LinkVariant title="Automatic Chevron" detail="Default indicator treatment." indicator="automatic" />
            <LinkVariant title="Visible Chevron" detail="Always show the indicator." indicator="visible" />
            <LinkVariant title="Hidden Chevron" detail="Suppress the indicator for custom row layouts." indicator="hidden" />
          </VStack>
        </Card>

        <Card title="Navigation Bar Display Modes">
          <VStack spacing={space.sm} alignment="leading">
            <NavigationLink navigationLinkIndicatorVisibility="visible" destination={<ChromePreviewScreen title="Large Title" displayMode="large" toolbarBackgroundVisibility="automatic" />}>
              <Label title="Large" systemName="textformat.size.larger" />
            </NavigationLink>
            <NavigationLink navigationLinkIndicatorVisibility="visible" destination={<ChromePreviewScreen title="Inline Title" displayMode="inline" toolbarBackgroundVisibility="visible" toolbarColorScheme="light" />}>
              <Label title="Inline + Visible Toolbar" systemName="textformat.size.smaller" />
            </NavigationLink>
            <NavigationLink navigationLinkIndicatorVisibility="visible" destination={<ChromePreviewScreen title="Automatic Title" displayMode="automatic" toolbarBackgroundVisibility="hidden" toolbarColorScheme="dark" />}>
              <Label title="Automatic + Hidden Toolbar" systemName="minus.square" />
            </NavigationLink>
          </VStack>
        </Card>

        <Card title="Toolbar Placements" detail="Preview crowded placements in isolated screens so the catalog tab itself stays readable.">
          <VStack spacing={space.sm} alignment="leading">
            <ToolbarPlacementsSheetLauncher
              title="Top Actions"
              navigationTitle=""
              toolbar={[
                { placement: "cancellationAction", content: <Button action={() => undefined} buttonStyle="plain"><Image systemName="xmark" /></Button> },
                { placement: "confirmationAction", content: <Button action={() => undefined} buttonStyle="plain">Done</Button> },
                { placement: "primaryAction", content: <Button action={() => undefined} buttonStyle="borderedProminent">Save</Button> },
              ]}
              summary="cancellationAction, confirmationAction, and primaryAction"
            />
            <ToolbarPlacementsSheetLauncher
              title="Bottom / Status"
              toolbar={[
                { placement: "bottomBar", content: <Text font="caption">Bottom</Text> },
                { placement: "status", content: <Text font="caption">Status</Text> },
                { placement: "automatic", content: <Text font="caption">Auto</Text> },
              ]}
              summary="bottomBar, status, and automatic"
            />
          </VStack>
        </Card>
      </DemoSection>

      <DemoSection title="Presentation APIs" detail="Sheet detents, drag indicators, background interaction, alert, dialog, and full-screen cover.">
        <Card title="Sheets">
          <VStack spacing={space.sm} alignment="leading">
            <SheetLauncher
              title="Detents + Automatic Background"
              detents={["medium", "large", { fraction: 0.35 }, { height: 220 }]}
              dragIndicator="automatic"
              backgroundInteraction="automatic"
            />
            <SheetLauncher
              title="Visible Handle + Enabled Background"
              detents={["medium", "large"]}
              dragIndicator="visible"
              backgroundInteraction="enabled"
            />
            <SheetLauncher
              title="Disabled Dismiss + Up Through Height"
              detents={[{ height: 220 }, "large"]}
              dragIndicator="hidden"
              backgroundInteraction={{ upThrough: { height: 220 } }}
              interactiveDismissDisabled
            />
          </VStack>
        </Card>

        <Card title="Alert / ConfirmationDialog / FullScreenCover">
          <HStack spacing={space.sm}>
            <Button action={() => setShowAlert(true)} buttonStyle="bordered">
              Show Alert
            </Button>
            <Button action={() => setShowDialog(true)} buttonStyle="bordered">
              Show Dialog
            </Button>
            <FullScreenCover
              isPresented={full}
              onDismiss={() => setFull(false)}
              interactiveDismissDisabled
              content={<FullScreenDemo onClose={() => setFull(false)} />}
            >
              <Button action={() => setFull(true)} buttonStyle="borderedProminent">
                Full Screen
              </Button>
            </FullScreenCover>
          </HStack>
        </Card>
      </DemoSection>

      <DemoSection title="Nested TabView" detail="Title-only, SF Symbol, asset-image, and badge variants inside the catalog.">
        <Card title="Tab Preview">
          <TabView selection="text" onSelectionChange={() => undefined} frame={{ height: 220 }}>
            <Tab title="Text" value="text">
              <TabBody label="Title only tab item" />
            </Tab>
            <Tab title="Symbol" value="symbol" systemName="sparkles" badge="1">
              <TabBody label="SF Symbol tab item" />
            </Tab>
            <Tab title="Asset" value="asset" name="CatalogMark" badge={2}>
              <TabBody label="Asset image tab item" />
            </Tab>
          </TabView>
        </Card>
      </DemoSection>
    </ScreenShell>
  )
}
