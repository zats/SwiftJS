import { Button, List, Section, Text, VStack } from "../swiftjs"
import { socialPosts } from "../Support/SampleData"

export function SocialFeedView() {
  return (
    <List navigationTitle="Social Feed" listStyle="insetGrouped">
      <Section>
        <VStack alignment="center" spacing={6} padding={18} background="indigo" cornerRadius={18}>
          <Text font="title2" fontWeight="bold" foregroundColor="white">
            Get Social Feed+
          </Text>
          <Text font="subheadline" foregroundColor="white">
            The premium social-feed experience from the original sample, recreated as portable SwiftJS UI.
          </Text>
          <Button action={() => {}} buttonStyle="borderedProminent" buttonBorderShape="roundedRectangle">
            Learn More
          </Button>
        </VStack>
      </Section>

      <Section title="Posts">
        {socialPosts.map((post) => (
          <VStack id={post.id} key={post.id} alignment="leading" spacing={4} padding={4}>
            <Text font="headline" fontWeight="semibold">
              {post.title}
            </Text>
            <Text font="subheadline" foregroundColor="secondary">
              {post.subtitle}
            </Text>
          </VStack>
        ))}
      </Section>
    </List>
  )
}
