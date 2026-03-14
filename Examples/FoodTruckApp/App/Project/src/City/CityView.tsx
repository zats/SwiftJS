import { Image, ScrollView, Text, VStack } from "../swiftjs"
import type { CityInfo } from "../Support/SampleData"

export function CityView(props: { city: CityInfo }) {
  return (
    <ScrollView id={`city-${props.city.id}`} navigationTitle={props.city.name} background="systemGroupedBackground">
      <VStack id={`city-stack-${props.city.id}`} alignment="leading" spacing={16} padding={16}>
        <VStack id={`city-hero-${props.city.id}`} alignment="trailing" spacing={12}>
          <Image
            id={`city-hero-image-${props.city.id}`}
            name="header/Static"
            frame={{ height: 240 }}
            imageContentMode="fit"
            cornerRadius={24}
          />
          <VStack
            id={`city-weather-card-${props.city.id}`}
            alignment="leading"
            spacing={4}
            padding={14}
            background="secondarySystemBackground"
            cornerRadius={18}
          >
            <Text id={`city-temp-${props.city.id}`} font="title2" fontWeight="bold">
              {props.city.temperature}
            </Text>
            <Text id={`city-forecast-${props.city.id}`} font="subheadline" foregroundColor="secondary">
              {props.city.forecast}
            </Text>
          </VStack>
        </VStack>

        <VStack id={`city-recommendation-card-${props.city.id}`} alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <Text id={`city-rec-title-${props.city.id}`} font="headline" fontWeight="semibold" foregroundColor="indigo">
            Recommendation
          </Text>
          <Text id={`city-rec-${props.city.id}`} font="body" foregroundColor="secondary">
            {props.city.recommendation}
          </Text>
        </VStack>

        <VStack id={`city-operations-card-${props.city.id}`} alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <Text id={`city-ops-title-${props.city.id}`} font="headline" fontWeight="semibold" foregroundColor="indigo">
            Operations
          </Text>
          <Text id={`city-clouds-${props.city.id}`} font="subheadline" foregroundColor="secondary">
            Cloud cover is currently {props.city.cloudCover}.
          </Text>
          <Text id={`city-stock-${props.city.id}`} font="subheadline" foregroundColor="secondary">
            Popular donuts this week include Strawberry Sprinkles, Blue Sky, and Rainbow Rally.
          </Text>
        </VStack>
      </VStack>
    </ScrollView>
  )
}
