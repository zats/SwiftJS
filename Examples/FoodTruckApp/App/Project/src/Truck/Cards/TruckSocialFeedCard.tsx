import { FlowLayout, Text, VStack } from "../../swiftjs"
import { trendingTopics } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckSocialFeedCard(props: { onSelect: (panel: Panel) => void }) {
  return (
    <VStack id="truck-social-feed-card" alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader
        id="truck-social-feed-card-header"
        panel="socialFeed"
        title="Social Feed"
        systemName="text.bubble"
        onSelect={() => props.onSelect("socialFeed")}
      />

      <FlowLayout
        id="truck-social-tags"
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
          <Text key={topic} id={`chip-${topic}`} font="footnote" padding={8} background="quaternarySystemFill" cornerRadius={12}>
            {topic}
          </Text>
        ))}
      </FlowLayout>

      <Text id="truck-social-feed-caption" font="footnote" foregroundColor="secondary">
        Trending Topics
      </Text>
    </VStack>
  )
}
