import { HStack, ScrollView, Text, VStack } from "../swiftjs"
import { donutCatalog } from "../Support/SampleData"
import { DonutThumbnail } from "../Support/DonutComponents"

export function SalesHistoryView() {
  return (
    <ScrollView id="sales-history-view" navigationTitle="Sales History" background="systemGroupedBackground">
      <VStack id="sales-history-stack" alignment="leading" spacing={16} padding={16}>
        <HStack id="sales-stats" spacing={12} compactVertical>
          <MetricCard id="sales-week" label="This Week" value="$18.4K" />
          <MetricCard id="sales-yesterday" label="Yesterday" value="$2.7K" />
          <MetricCard id="sales-orders" label="Orders" value="148" />
        </HStack>

        <VStack id="sales-top-donuts-card" alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
          <HStack id="sales-top-donuts-header" spacing={8}>
            <Text id="sales-top-donuts-title" font="headline" fontWeight="semibold" foregroundColor="indigo">
              Top Donuts
            </Text>
          </HStack>
          <VStack id="sales-top-donuts" alignment="leading" spacing={10}>
            {donutCatalog.map((donut, index) => (
              <HStack id={`sales-top-${donut.id}`} key={donut.id} spacing={10}>
                <Text id={`sales-rank-${donut.id}`} font="headline" fontWeight="bold">
                  {index + 1}.
                </Text>
                <DonutThumbnail recipe={donut} />
                <VStack id={`sales-copy-${donut.id}`} alignment="leading" spacing={2}>
                  <Text id={`sales-name-${donut.id}`} font="headline" fontWeight="semibold">
                    {donut.name}
                  </Text>
                  <Text id={`sales-value-${donut.id}`} font="subheadline" foregroundColor="secondary">
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

function MetricCard(props: { id: string; label: string; value: string }) {
  return (
    <VStack id={props.id} alignment="leading" spacing={6} padding={14} background="secondarySystemBackground" cornerRadius={18}>
      <Text id={`${props.id}-value`} font="title2" fontWeight="bold">
        {props.value}
      </Text>
      <Text id={`${props.id}-label`} font="subheadline" foregroundColor="secondary">
        {props.label}
      </Text>
    </VStack>
  )
}
