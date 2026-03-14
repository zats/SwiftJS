import { HStack, List, Section, Text, VStack } from "../swiftjs"
import { donutCatalog } from "../Support/SampleData"
import { DonutThumbnail } from "../Support/DonutComponents"

export function TopFiveDonutsView() {
  return (
    <List id="top-five-view" navigationTitle="Top 5" listStyle="insetGrouped">
      <Section id="top-five-section" title="Best Sellers">
        {donutCatalog.map((donut, index) => (
          <HStack id={`top-five-${donut.id}`} key={donut.id} spacing={12} padding={4}>
            <Text id={`top-five-rank-${donut.id}`} font="headline" fontWeight="bold">
              {index + 1}
            </Text>
            <DonutThumbnail recipe={donut} />
            <VStack id={`top-five-copy-${donut.id}`} alignment="leading" spacing={2}>
              <Text id={`top-five-name-${donut.id}`} font="headline" fontWeight="semibold">
                {donut.name}
              </Text>
              <Text id={`top-five-sales-${donut.id}`} font="subheadline" foregroundColor="secondary">
                {donut.sales}
              </Text>
            </VStack>
          </HStack>
        ))}
      </Section>
    </List>
  )
}
