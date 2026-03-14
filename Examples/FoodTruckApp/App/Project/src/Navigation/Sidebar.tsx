import { Button, HStack, Image, List, Section, Spacer, Text } from "../swiftjs"
import { cities, cityPanel, donutPanels } from "../Support/SampleData"
import type { Panel } from "../Support/SampleData"

export function Sidebar(props: { selection: Panel; onSelect: (panel: Panel) => void }) {
  return (
    <List id="sidebar" navigationTitle="Food Truck" listStyle="sidebar">
      <SidebarRow
        id="sidebar-truck"
        title="Truck"
        systemName="box.truck"
        selected={props.selection === "truck"}
        action={() => props.onSelect("truck")}
      />
      <SidebarRow
        id="sidebar-orders"
        title="Orders"
        systemName="shippingbox"
        selected={props.selection === "orders"}
        action={() => props.onSelect("orders")}
      />
      <SidebarRow
        id="sidebar-feed"
        title="Social Feed"
        systemName="text.bubble"
        selected={props.selection === "socialFeed"}
        action={() => props.onSelect("socialFeed")}
      />
      <SidebarRow
        id="sidebar-history"
        title="Sales History"
        systemName="clock"
        selected={props.selection === "salesHistory"}
        action={() => props.onSelect("salesHistory")}
      />

      <Section id="sidebar-donuts" title="Donuts">
        {donutPanels.map((item) => (
          <SidebarRow
            id={`sidebar-${item.panel}`}
            key={item.panel}
            title={item.title}
            selected={props.selection === item.panel}
            action={() => props.onSelect(item.panel)}
            {...(item.icon.includes("/") ? { assetName: item.icon } : { systemName: item.icon })}
          />
        ))}
      </Section>

      <Section id="sidebar-cities" title="Cities">
        {cities.map((city) => (
          <SidebarRow
            id={`sidebar-${city.id}`}
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
  id: string
  title: string
  selected: boolean
  action: () => void
  systemName?: string
  assetName?: string
}) {
  return (
    <Button
      id={props.id}
      action={props.action}
      buttonStyle="plain"
      padding={8}
      background={props.selected ? "tertiarySystemFill" : "clear"}
      cornerRadius={12}
    >
      <HStack id={`${props.id}-row`} spacing={10}>
        {props.assetName ? (
          <Image id={`${props.id}-asset`} name={props.assetName} frame={{ width: 18, height: 18 }} />
        ) : (
          <Image id={`${props.id}-icon`} systemName={props.systemName ?? "circle"} />
        )}
        <Text id={`${props.id}-title`} font="body" fontWeight={props.selected ? "semibold" : "regular"}>
          {props.title}
        </Text>
        <Spacer id={`${props.id}-spacer`} />
      </HStack>
    </Button>
  )
}
