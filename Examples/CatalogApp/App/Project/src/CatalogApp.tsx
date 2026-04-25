import { Tab, TabView, useAppStorage } from "swiftjs"
import { ControlsTab } from "./catalog/screens/ControlsTab"
import { LayoutTab } from "./catalog/screens/LayoutTab"
import { ListsTab } from "./catalog/screens/ListsTab"
import { ModulesTab } from "./catalog/screens/ModulesTab"
import { PresentationTab } from "./catalog/screens/PresentationTab"
import { VisualsTab } from "./catalog/screens/VisualsTab"

export function CatalogApp() {
  const [selectedTab, setSelectedTab] = useAppStorage<string>("catalog.selectedTab", "layout")

  return (
    <TabView selection={selectedTab} onSelectionChange={(next) => setSelectedTab(String(next))}>
      <Tab title="Layout" value="layout" systemName="square.grid.2x2">
        <LayoutTab />
      </Tab>
      <Tab title="Controls" value="controls" systemName="switch.2" badge="!">
        <ControlsTab />
      </Tab>
      <Tab title="Lists" value="lists" systemName="list.bullet.rectangle" badge={4}>
        <ListsTab />
      </Tab>
      <Tab title="Present" value="present" systemName="square.on.square">
        <PresentationTab />
      </Tab>
      <Tab title="Modules" value="modules" systemName="puzzlepiece.extension">
        <ModulesTab />
      </Tab>
      <Tab title="Visuals" value="visuals" name="CatalogMark">
        <VisualsTab />
      </Tab>
    </TabView>
  )
}
