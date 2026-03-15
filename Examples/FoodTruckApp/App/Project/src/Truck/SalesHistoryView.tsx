import { HStack, ScrollView, Text, VStack } from "../swiftjs"
import { donutCatalog } from "../Support/SampleData"
import { DonutThumbnail } from "../Support/DonutComponents"

export function SalesHistoryView() {
  return (
    <ScrollView navigationTitle="Sales History" background="systemGroupedBackground">
      <VStack alignment="leading" spacing={16} padding={16}>
        <HStack spacing={12} compactVertical>
          <MetricCard label="This Week" value="$18.4K" />
          <MetricCard label="Yesterday" value="$2.7K" />
          <MetricCard label="Orders" value="148" />
        </HStack>

        <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <HStack spacing={8}>
            <Text font="headline" fontWeight="semibold" foregroundColor="indigo">
              Top Donuts
            </Text>
          </HStack>
          <VStack alignment="leading" spacing={10}>
            {donutCatalog.map((donut, index) => (
              <HStack key={donut.id} spacing={10}>
                <Text font="headline" fontWeight="bold">
                  {index + 1}.
                </Text>
                <DonutThumbnail recipe={donut} />
                <VStack alignment="leading" spacing={2}>
                  <Text font="headline" fontWeight="semibold">
                    {donut.name}
                  </Text>
                  <Text font="subheadline" foregroundColor="secondary">
                    Weekly sales {donut.sales}
                  </Text>
                </VStack>
              </HStack>
            ))}
          </VStack>
        </VStack>
      </VStack>
    </ScrollView>
  )
}

function MetricCard(props: { label: string; value: string }) {
  return (
    <VStack alignment="leading" spacing={6} padding={14} background="secondarySystemBackground" cornerRadius={18}>
      <Text font="title2" fontWeight="bold">
        {props.value}
      </Text>
      <Text font="subheadline" foregroundColor="secondary">
        {props.label}
      </Text>
    </VStack>
  )
}
