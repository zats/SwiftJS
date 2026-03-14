import { Grid, GridRow, Image, ScrollView, VStack, WidthThreshold } from "../swiftjs"
import type { Panel } from "../Support/SampleData"
import { TruckDonutsCard } from "./Cards/TruckDonutsCard"
import { TruckOrdersCard } from "./Cards/TruckOrdersCard"
import { TruckSocialFeedCard } from "./Cards/TruckSocialFeedCard"
import { TruckWeatherCard } from "./Cards/TruckWeatherCard"

export function TruckView(props: { onSelect: (panel: Panel) => void }) {
  return (
    <WidthThreshold
      id="truck-width-threshold"
      threshold={520}
      compact={<TruckContent onSelect={props.onSelect} compact />}
      regular={<TruckContent onSelect={props.onSelect} compact={false} />}
    />
  )
}

function TruckContent(props: { onSelect: (panel: Panel) => void; compact: boolean }) {
  return (
    <ScrollView id="truck-view" navigationTitle="Truck" background="systemGroupedBackground">
      <VStack id="truck-stack" spacing={16}>
        <BrandHeader />
        <Grid
          id="truck-grid"
          horizontalSpacing={12}
          verticalSpacing={12}
          fixedSize={{ horizontal: false, vertical: true }}
          padding={16}
          frame={{ maxWidth: 1200 }}
        >
          {props.compact ? (
            <>
              <TruckOrdersCard onSelect={props.onSelect} />
              <TruckWeatherCard onSelect={props.onSelect} />
              <TruckDonutsCard onSelect={props.onSelect} />
              <TruckSocialFeedCard onSelect={props.onSelect} />
            </>
          ) : (
            <>
              <GridRow id="truck-grid-row-1">
                <TruckOrdersCard onSelect={props.onSelect} />
                <TruckWeatherCard onSelect={props.onSelect} />
              </GridRow>
              <GridRow id="truck-grid-row-2">
                <TruckDonutsCard onSelect={props.onSelect} />
                <TruckSocialFeedCard onSelect={props.onSelect} />
              </GridRow>
            </>
          )}
        </Grid>
      </VStack>
    </ScrollView>
  )
}

function BrandHeader() {
  return <Image id="truck-hero" name="header/Static" frame={{ height: 205 }} imageContentMode="fill" />
}
