import { BrandHeader } from "../Brand/BrandHeader"
import { WidthThresholdReader } from "../General/WidthThresholdReader"
import { Grid, GridRow, ScrollView, VStack } from "../swiftjs"
import type { Panel } from "../Support/SampleData"
import { TruckDonutsCard } from "./Cards/TruckDonutsCard"
import { TruckOrdersCard } from "./Cards/TruckOrdersCard"
import { TruckSocialFeedCard } from "./Cards/TruckSocialFeedCard"
import { TruckWeatherCard } from "./Cards/TruckWeatherCard"

export function TruckView(props: { onSelect: (panel: Panel) => void }) {
  return (
    <WidthThresholdReader id="truck-width-threshold" widthThreshold={520}>
      {(proxy) => <TruckContent onSelect={props.onSelect} isCompact={proxy.isCompact} />}
    </WidthThresholdReader>
  )
}

function TruckContent(props: { onSelect: (panel: Panel) => void; isCompact: boolean }) {
  const orders = <TruckOrdersCard onSelect={props.onSelect} />
  const weather = <TruckWeatherCard onSelect={props.onSelect} />
  const donuts = <TruckDonutsCard onSelect={props.onSelect} />
  const socialFeed = <TruckSocialFeedCard onSelect={props.onSelect} />

  return (
    <ScrollView id="truck-view" navigationTitle="Truck" background="systemGroupedBackground">
      <VStack id="truck-stack" spacing={16}>
        <BrandHeader animated={false} />
        <Grid
          id="truck-grid"
          horizontalSpacing={12}
          verticalSpacing={12}
          fixedSize={{ horizontal: false, vertical: true }}
          padding={16}
          frame={{ maxWidth: 1200 }}
        >
          {props.isCompact ? (
            <>
              {orders}
              {weather}
              {donuts}
              {socialFeed}
            </>
          ) : (
            <>
              <GridRow id="truck-grid-row-1">
                {orders}
                {weather}
              </GridRow>
              <GridRow id="truck-grid-row-2">
                {donuts}
                {socialFeed}
              </GridRow>
            </>
          )}
        </Grid>
      </VStack>
    </ScrollView>
  )
}
