import { HStack, Text, VStack } from "../../swiftjs"
import { cityPanel, formatForecastHour, truckForecast } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckWeatherCard(props: { onSelect: (panel: Panel) => void }) {
  const low = Math.min(...truckForecast.entries.map((entry) => entry.degrees))
  const high = Math.max(...truckForecast.entries.map((entry) => entry.degrees))
  const visibleEntries = truckForecast.entries.filter((_, index) => index % 3 === 0).slice(0, 6)
  const span = Math.max(high - low, 1)

  return (
    <VStack id="truck-weather-card" alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader
        id="truck-weather-card-header"
        panel={cityPanel("san-francisco")}
        title="Forecast"
        systemName="cloud.sun"
        onSelect={() => props.onSelect(cityPanel("san-francisco"))}
      />

      <VStack id="truck-weather-chart" alignment="leading" spacing={12} frame={{ minHeight: 180 }}>
        <HStack id="truck-weather-bars" spacing={10}>
          {visibleEntries.map((entry) => {
            const normalizedHeight = 44 + ((entry.degrees - low) / span) * 76

            return (
              <VStack id={`truck-weather-bar-${entry.date.toISOString()}`} key={entry.date.toISOString()} alignment="center" spacing={8}>
                <VStack
                  id={`truck-weather-bar-fill-${entry.date.toISOString()}`}
                  background={entry.isDaylight ? "teal" : "indigo"}
                  cornerRadius={12}
                  frame={{ width: 22, height: normalizedHeight }}
                />
                <Text id={`truck-weather-bar-label-${entry.date.toISOString()}`} font="caption" foregroundColor="secondary">
                  {formatForecastHour(entry.date)}
                </Text>
                <Text id={`truck-weather-bar-value-${entry.date.toISOString()}`} font="caption" fontWeight="semibold">
                  {entry.degrees}°
                </Text>
              </VStack>
            )
          })}
        </HStack>
        <Text id="truck-weather-summary" font="footnote" foregroundColor="secondary">
          {low}°F to {high}°F
        </Text>
      </VStack>
    </VStack>
  )
}
