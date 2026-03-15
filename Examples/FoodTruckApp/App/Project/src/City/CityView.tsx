import { Image, ScrollView, Text, VStack } from "../swiftjs"
import type { CityInfo } from "../Support/SampleData"

export function CityView(props: { city: CityInfo }) {
  return (
    <ScrollView navigationTitle={props.city.name} background="systemGroupedBackground">
      <VStack alignment="leading" spacing={16} padding={16}>
        <VStack alignment="trailing" spacing={12}>
          <Image
            name="header/Static"
            frame={{ height: 240 }}
            imageContentMode="fit"
            cornerRadius={24}
          />
          <VStack alignment="leading" spacing={4} padding={14} background="secondarySystemBackground" cornerRadius={18}>
            <Text font="title2" fontWeight="bold">
              {props.city.temperature}
            </Text>
            <Text font="subheadline" foregroundColor="secondary">
              {props.city.forecast}
            </Text>
          </VStack>
        </VStack>

        <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <Text font="headline" fontWeight="semibold" foregroundColor="indigo">
            Recommendation
          </Text>
          <Text font="body" foregroundColor="secondary">
            {props.city.recommendation}
          </Text>
        </VStack>

        <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <Text font="headline" fontWeight="semibold" foregroundColor="indigo">
            Operations
          </Text>
          <Text font="subheadline" foregroundColor="secondary">
            Cloud cover is currently {props.city.cloudCover}.
          </Text>
          <Text font="subheadline" foregroundColor="secondary">
            Popular donuts this week include Strawberry Sprinkles, Blue Sky, and Rainbow Rally.
          </Text>
        </VStack>
      </VStack>
    </ScrollView>
  )
}
