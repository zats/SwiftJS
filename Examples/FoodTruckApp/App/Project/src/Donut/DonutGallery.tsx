import { HStack, ScrollView, Text, VStack } from "../swiftjs"
import type { Panel } from "../Support/SampleData"
import { donutCatalog } from "../Support/SampleData"
import { GalleryTile } from "../Support/DonutComponents"

export function DonutGallery(props: { onSelect: (panel: Panel) => void }) {
  return (
    <ScrollView id="donut-gallery-view" navigationTitle="Donuts" background="systemGroupedBackground">
      <VStack id="donut-gallery-stack" alignment="leading" spacing={16} padding={16}>
        <VStack id="donut-gallery-card" alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <HStack id="donut-gallery-header" spacing={8}>
            <Text id="donut-gallery-title" font="headline" fontWeight="semibold" foregroundColor="indigo">
              Gallery
            </Text>
          </HStack>
          <VStack id="donut-gallery-grid" alignment="leading" spacing={12}>
            <HStack id="gallery-row-1" spacing={12} compactVertical>
              {donutCatalog.slice(0, 3).map((donut) => (
                <GalleryTile key={donut.id} recipe={donut} />
              ))}
            </HStack>
            <HStack id="gallery-row-2" spacing={12} compactVertical>
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
