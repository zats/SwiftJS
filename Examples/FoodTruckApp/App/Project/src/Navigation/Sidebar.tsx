import { Button, HStack, Image, List, Section, Spacer, Text } from "../swiftjs"
import { cities, cityPanel, donutPanels } from "../Support/SampleData"
import type { Panel } from "../Support/SampleData"

export function Sidebar(props: { selection: Panel; onSelect: (panel: Panel) => void }) {
  return (
    <List navigationTitle="Food Truck" listStyle="sidebar">
      <SidebarRow
        title="Truck"
        systemName="box.truck"
        selected={props.selection === "truck"}
        action={() => props.onSelect("truck")}
      />
      <SidebarRow
        title="Orders"
        systemName="shippingbox"
        selected={props.selection === "orders"}
        action={() => props.onSelect("orders")}
      />
      <SidebarRow
        title="Social Feed"
        systemName="text.bubble"
        selected={props.selection === "socialFeed"}
        action={() => props.onSelect("socialFeed")}
      />
      <SidebarRow
        title="Sales History"
        systemName="clock"
        selected={props.selection === "salesHistory"}
        action={() => props.onSelect("salesHistory")}
      />

      <Section title="Donuts">
        {donutPanels.map((item) => (
          <SidebarRow
            key={item.panel}
            title={item.title}
            selected={props.selection === item.panel}
            action={() => props.onSelect(item.panel)}
            {...(item.icon.includes("/") ? { assetName: item.icon } : { systemName: item.icon })}
          />
        ))}
      </Section>

      <Section title="Cities">
        {cities.map((city) => (
          <SidebarRow
            key={city.id}
            title={city.name}
            systemName="building.2"
            selected={props.selection === cityPanel(city.id)}
            action={() => props.onSelect(cityPanel(city.id))}
          />
        ))}
      </Section>
    </List>
  )
}

function SidebarRow(props: {
  title: string
  selected: boolean
  action: () => void
  systemName?: string
  assetName?: string
}) {
  return (
    <Button
      action={props.action}
      buttonStyle="plain"
      padding={8}
      background={props.selected ? "tertiarySystemFill" : "clear"}
      cornerRadius={12}
    >
      <HStack spacing={10}>
        {props.assetName ? <Image name={props.assetName} frame={{ width: 18, height: 18 }} /> : <Image systemName={props.systemName ?? "circle"} />}
        <Text font="body" fontWeight={props.selected ? "semibold" : "regular"}>
          {props.title}
        </Text>
        <Spacer />
      </HStack>
    </Button>
  )
}
