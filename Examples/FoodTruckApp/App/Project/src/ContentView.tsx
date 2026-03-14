import { Button, Divider, HStack, Image, Text, VStack, useState } from "./swiftjs"

const heroHeight = 158
const panelSpacing = 18

const sections = [
  { id: "truck", title: "Truck", subtitle: "Dashboard cards and entry points" },
  { id: "orders", title: "Orders", subtitle: "Grouped list, search, and detail flow" },
  { id: "donuts", title: "Donuts", subtitle: "Gallery, editor, and layered assets" },
  { id: "city", title: "City", subtitle: "Weather, map placeholder, and recommendations" },
] as const

type SectionID = (typeof sections)[number]["id"]

export function ContentView() {
  const [selectedSection, setSelectedSection] = useState<SectionID>("truck")

  const activeSection = sections.find((section) => section.id === selectedSection) ?? sections[0]

  return (
    <VStack id="food-truck-root" spacing={panelSpacing} padding={20}>
      <Image
        id="food-truck-header"
        name="header/Static"
        frame={{ height: heroHeight }}
      />

      <VStack id="food-truck-copy" spacing={8}>
        <Text id="food-truck-title" font="largeTitle" fontWeight="bold">
          Food Truck
        </Text>

        <Text id="food-truck-subtitle" font="body" foregroundColor="secondary">
          Separate SwiftJS sample app. First pass is wired to the local package and bundled assets.
        </Text>
      </VStack>

      <HStack id="food-truck-overview" spacing={12} padding={14} background="white" cornerRadius={18}>
        <Image
          id="food-truck-box"
          name="box/Composed"
          frame={{ width: 92, height: 92 }}
        />

        <VStack id="food-truck-overview-copy" spacing={6}>
          <Text id="food-truck-overview-title" font="title" fontWeight="semibold">
            Iteration Zero
          </Text>

          <Text id="food-truck-overview-body" font="body" foregroundColor="secondary">
            Assets load from the sample bundle. Next iterations will expand the native binding surface and move real Food Truck behavior into JS.
          </Text>
        </VStack>
      </HStack>

      <VStack id="food-truck-section-list" spacing={10}>
        {sections.map((section) => (
          <Button
            id={`section-${section.id}`}
            action={() => setSelectedSection(section.id)}
            buttonStyle={selectedSection === section.id ? "borderedProminent" : "bordered"}
            buttonBorderShape="roundedRectangle"
            padding={14}
          >
            {section.title}
          </Button>
        ))}
      </VStack>

      <Divider id="food-truck-divider" />

      <VStack id="food-truck-active-section" spacing={8} padding={18} background="white" cornerRadius={20}>
        <Text id="food-truck-active-title" font="title" fontWeight="bold">
          {activeSection.title}
        </Text>

        <Text id="food-truck-active-subtitle" font="body" foregroundColor="secondary">
          {activeSection.subtitle}
        </Text>
      </VStack>
    </VStack>
  )
}
