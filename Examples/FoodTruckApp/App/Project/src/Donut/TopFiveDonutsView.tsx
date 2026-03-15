import { HStack, List, Section, Text, VStack } from "../swiftjs"
import { donutCatalog } from "../Support/SampleData"
import { DonutThumbnail } from "../Support/DonutComponents"

export function TopFiveDonutsView() {
  return (
    <List navigationTitle="Top 5" listStyle="insetGrouped">
      <Section title="Best Sellers">
        {donutCatalog.map((donut, index) => (
          <HStack key={donut.id} spacing={12} padding={4}>
            <Text font="headline" fontWeight="bold">
              {index + 1}
            </Text>
            <DonutThumbnail recipe={donut} />
            <VStack alignment="leading" spacing={2}>
              <Text font="headline" fontWeight="semibold">
                {donut.name}
              </Text>
              <Text font="subheadline" foregroundColor="secondary">
                {donut.sales}
              </Text>
            </VStack>
          </HStack>
        ))}
      </Section>
    </List>
  )
}
