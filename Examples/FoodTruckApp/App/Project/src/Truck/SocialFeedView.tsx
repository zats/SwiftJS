import { Button, List, Section, Text, VStack } from "../swiftjs"
import { socialPosts } from "../Support/SampleData"

export function SocialFeedView() {
  return (
    <List id="social-feed-view" navigationTitle="Social Feed" listStyle="insetGrouped">
      <Section id="social-plus-section">
        <VStack id="social-plus-card" alignment="center" spacing={6} padding={18} background="indigo" cornerRadius={18}>
          <Text id="social-plus-title" font="title2" fontWeight="bold" foregroundColor="white">
            Get Social Feed+
          </Text>
          <Text id="social-plus-copy" font="subheadline" foregroundColor="white">
            The premium social-feed experience from the original sample, recreated as portable SwiftJS UI.
          </Text>
          <Button id="social-plus-button" action={() => {}} buttonStyle="borderedProminent" buttonBorderShape="roundedRectangle">
            Learn More
          </Button>
        </VStack>
      </Section>

      <Section id="social-posts" title="Posts">
        {socialPosts.map((post) => (
          <VStack id={post.id} key={post.id} alignment="leading" spacing={4} padding={4}>
            <Text id={`${post.id}-title`} font="headline" fontWeight="semibold">
              {post.title}
            </Text>
            <Text id={`${post.id}-subtitle`} font="subheadline" foregroundColor="secondary">
              {post.subtitle}
            </Text>
          </VStack>
        ))}
      </Section>
    </List>
  )
}
