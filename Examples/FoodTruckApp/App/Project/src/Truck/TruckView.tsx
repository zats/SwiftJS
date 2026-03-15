import { BrandHeader } from "../Brand/BrandHeader"
import { WidthThresholdReader } from "../General/WidthThresholdReader"
import { Grid, GridRow, ScrollView, VStack } from "../swiftjs"
import { truckShowcaseDonuts, type Panel } from "../Support/SampleData"
import { TruckDonutsCard } from "./Cards/TruckDonutsCard"
import { TruckOrdersCard } from "./Cards/TruckOrdersCard"
import { TruckSocialFeedCard } from "./Cards/TruckSocialFeedCard"
import { TruckWeatherCard } from "./Cards/TruckWeatherCard"

export function TruckView(props: { onSelect: (panel: Panel) => void }) {
  return (
    <WidthThresholdReader widthThreshold={520}>
      {(proxy) => <TruckContent onSelect={props.onSelect} isCompact={proxy.isCompact} />}
    </WidthThresholdReader>
  )
}

function TruckContent(props: { onSelect: (panel: Panel) => void; isCompact: boolean }) {
  const orders = <TruckOrdersCard onSelect={props.onSelect} />
  const weather = <TruckWeatherCard onSelect={props.onSelect} />
  const donuts = <TruckDonutsCard donuts={truckShowcaseDonuts} onSelect={props.onSelect} />
  const socialFeed = <TruckSocialFeedCard onSelect={props.onSelect} />

  return (
    <ScrollView navigationTitle="Truck" background="systemGroupedBackground">
      <VStack spacing={16}>
        <BrandHeader animated={false} />
        <Grid
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
              <GridRow>
                {orders}
                {weather}
              </GridRow>
              <GridRow>
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
