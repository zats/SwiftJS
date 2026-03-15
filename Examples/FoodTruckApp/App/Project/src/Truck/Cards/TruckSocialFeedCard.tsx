import { FlowLayout, Label, Text, VStack } from "../../swiftjs"
import { trendingTopics } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckSocialFeedCard(props: { onSelect: (panel: Panel) => void }) {
  return (
    <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader onSelect={() => props.onSelect("socialFeed")}>
        <Label title="Social Feed" systemName="text.bubble" font="headline" fontWeight="semibold" foregroundColor="indigo" />
      </CardNavigationHeader>

      <FlowLayout
        alignment="center"
        spacing={8}
        lineSpacing={8}
        padding={12}
        paddingTop={15}
        background="quaternarySystemFill"
        cornerRadius={18}
        frame={{ maxWidth: "infinity", minHeight: 180 }}
      >
        {trendingTopics.map((topic) => (
          <Text key={topic} font="footnote" padding={8} background="quaternarySystemFill" cornerRadius={12}>
            {topic}
          </Text>
        ))}
      </FlowLayout>

      <Text font="footnote" foregroundColor="secondary">
        Trending Topics
      </Text>
    </VStack>
  )
}
