import { HStack, ScrollView, Text, VStack } from "../swiftjs"
import type { Panel } from "../Support/SampleData"
import { donutCatalog } from "../Support/SampleData"
import { GalleryTile } from "../Support/DonutComponents"

export function DonutGallery(props: { onSelect: (panel: Panel) => void }) {
  return (
    <ScrollView navigationTitle="Donuts" background="systemGroupedBackground">
      <VStack alignment="leading" spacing={16} padding={16}>
        <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <HStack spacing={8}>
            <Text font="headline" fontWeight="semibold" foregroundColor="indigo">
              Gallery
            </Text>
          </HStack>
          <VStack alignment="leading" spacing={12}>
            <HStack spacing={12} compactVertical>
              {donutCatalog.slice(0, 3).map((donut) => (
                <GalleryTile key={donut.id} recipe={donut} />
              ))}
            </HStack>
            <HStack spacing={12} compactVertical>
              {donutCatalog.slice(2, 5).map((donut) => (
                <GalleryTile key={donut.id} recipe={donut} />
              ))}
            </HStack>
          </VStack>
        </VStack>
      </VStack>
    </ScrollView>
  )
}
