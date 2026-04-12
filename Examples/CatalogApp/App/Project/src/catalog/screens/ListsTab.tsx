import { Form, HStack, Label, List, Picker, ScrollView, Section, Toggle } from "../../swiftjs"
import { Card, DemoSection, ListPreview, ScreenShell } from "../components/common"
import { space } from "../shared"
import { listsToolbar } from "../toolbars"

export function ListsTab() {
  return (
    <ScreenShell title="Lists" toolbar={listsToolbar}>
      <DemoSection title="List Styles" detail="Every supported list style in a fixed preview frame.">
        <ScrollView axis="horizontal">
          <HStack spacing={space.md} padding={space.xs}>
            <ListPreview title="Automatic" style="automatic" />
            <ListPreview title="Plain" style="plain" />
            <ListPreview title="Grouped" style="grouped" scrollContentBackground="hidden" />
            <ListPreview title="Inset" style="inset" listRowSeparator="hidden" listRowBackground="tertiarySystemBackground" />
            <ListPreview title="Inset Grouped" style="insetGrouped" listSectionSeparator="hidden" />
            <ListPreview title="Sidebar" style="sidebar" />
          </HStack>
        </ScrollView>
      </DemoSection>

      <DemoSection title="Row Chrome" detail="Separators, row insets, row backgrounds, and content margins.">
        <Card title="Customized Rows">
          <List
            frame={{ height: 250 }}
            listStyle="insetGrouped"
            scrollContentBackground="hidden"
            listRowSeparator="hidden"
            listSectionSeparator="hidden"
            listRowBackground="secondarySystemBackground"
            listRowInsets={{ top: 14, bottom: 14, leading: 18, trailing: 18 }}
            contentMargins={[
              { edges: "horizontal", amount: 12, placement: "scrollContent" },
              { edges: "bottom", amount: 24, placement: "scrollIndicators" },
            ]}
          >
            <Section title="Today">
              <Label title="Inbox Zero" systemName="tray.full" />
              <Label title="Pinned Notes" systemName="pin" />
            </Section>
            <Section title="Later">
              <Label title="Review Builds" systemName="hammer" />
              <Label title="Archive" systemName="archivebox" />
            </Section>
          </List>
        </Card>
      </DemoSection>

      <DemoSection title="Form" detail="Form + Section inside the same host surface.">
        <Card title="Preferences Form">
          <Form frame={{ height: 280 }} scrollContentBackground="hidden">
            <Section title="Playback">
              <Toggle isOn onChange={() => undefined}>
                Autoplay previews
              </Toggle>
              <Picker selection="default" onChange={() => undefined} options={["default", "compact", "dense"]}>
                Density
              </Picker>
            </Section>
            <Section title="Sync">
              <Toggle isOn={false} onChange={() => undefined}>
                Cellular data
              </Toggle>
              <Label title="Offline Cache" systemName="internaldrive" />
            </Section>
          </Form>
        </Card>
      </DemoSection>
    </ScreenShell>
  )
}
