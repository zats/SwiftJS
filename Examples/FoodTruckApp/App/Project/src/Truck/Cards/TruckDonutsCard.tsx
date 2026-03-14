import { HStack, Spacer, VStack } from "../../swiftjs"
import { truckShowcaseDonuts } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { DonutPreview } from "../../Support/DonutComponents"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckDonutsCard(props: { onSelect: (panel: Panel) => void }) {
  return (
    <VStack id="truck-donuts-card" alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader
        id="truck-donuts-card-header"
        panel="donuts"
        title="Donuts"
        assetName="donut"
        onSelect={() => props.onSelect("donuts")}
      />

      <VStack id="truck-donuts-card-content" alignment="leading" spacing={10} frame={{ minHeight: 180 }}>
        <HStack id="truck-donuts-row-1" spacing={10}>
          {truckShowcaseDonuts.slice(0, 5).map((donut, index) => (
            <VStack key={`truck-row-1-${index}-${donut.id}`} id={`truck-row-1-${index}-${donut.id}`}>
              <DonutPreview recipe={donut} size="lattice" />
            </VStack>
          ))}
        </HStack>
        <HStack id="truck-donuts-row-2" spacing={10}>
          <Spacer id="truck-donuts-row-2-leading" />
          {truckShowcaseDonuts.slice(5, 9).map((donut, index) => (
            <VStack key={`truck-row-2-${index}-${donut.id}`} id={`truck-row-2-${index}-${donut.id}`}>
              <DonutPreview recipe={donut} size="lattice" />
            </VStack>
          ))}
          <Spacer id="truck-donuts-row-2-trailing" />
        </HStack>
        <HStack id="truck-donuts-row-3" spacing={10}>
          {truckShowcaseDonuts.slice(9, 14).map((donut, index) => (
            <VStack key={`truck-row-3-${index}-${donut.id}`} id={`truck-row-3-${index}-${donut.id}`}>
              <DonutPreview recipe={donut} size="lattice" />
            </VStack>
          ))}
        </HStack>
      </VStack>
    </VStack>
  )
}
