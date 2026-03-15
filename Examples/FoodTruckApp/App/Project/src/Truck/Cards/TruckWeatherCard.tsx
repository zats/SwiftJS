import { HStack, Label, Text, VStack } from "../../swiftjs"
import { cityPanel, formatForecastHour, truckForecast } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckWeatherCard(props: { onSelect: (panel: Panel) => void }) {
  const low = Math.min(...truckForecast.entries.map((entry) => entry.degrees))
  const high = Math.max(...truckForecast.entries.map((entry) => entry.degrees))
  const visibleEntries = truckForecast.entries.filter((_, index) => index % 3 === 0).slice(0, 6)
  const span = Math.max(high - low, 1)

  return (
    <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader onSelect={() => props.onSelect(cityPanel("san-francisco"))}>
        <Label title="Forecast" systemName="cloud.sun" font="headline" fontWeight="semibold" foregroundColor="indigo" />
      </CardNavigationHeader>

      <VStack alignment="leading" spacing={12} frame={{ minHeight: 180 }}>
        <HStack spacing={10}>
          {visibleEntries.map((entry) => {
            const normalizedHeight = 44 + ((entry.degrees - low) / span) * 76

            return (
              <VStack key={entry.date.toISOString()} alignment="center" spacing={8}>
                <VStack
                  background={entry.isDaylight ? "teal" : "indigo"}
                  cornerRadius={12}
                  frame={{ width: 22, height: normalizedHeight }}
                />
                <Text font="caption" foregroundColor="secondary">
                  {formatForecastHour(entry.date)}
                </Text>
                <Text font="caption" fontWeight="semibold">
                  {entry.degrees}°
                </Text>
              </VStack>
            )
          })}
        </HStack>
        <Text font="footnote" foregroundColor="secondary">
          {low}°F to {high}°F
        </Text>
      </VStack>
    </VStack>
  )
}
