import {
  FlowLayout,
  GeometryReader,
  Grid,
  GridRow,
  HStack,
  Image,
  LinearGradient,
  Label,
  NavigationLink,
  RoundedRectangle,
  ScrollView,
  Spacer,
  Text,
  VStack,
  ViewThatFits,
  ZStack,
  useState,
} from "swiftjs"
import { CatalogOrbitLayout } from "../../CatalogOrbitLayout"
import { Card, DemoSection, InsetBar, Pill, ScreenShell, ValuePlate } from "../components/common"
import { space } from "../shared"
import { layoutToolbar } from "../toolbars"

export function LayoutTab() {
  const [appearCount, setAppearCount] = useState(0)

  return (
    <ScreenShell
      title="Layout"
      toolbar={layoutToolbar}
      safeAreaInset={[
        {
          edge: "top",
          content: <InsetBar title="Top Inset" detail="safeAreaInset(top)" />,
        },
        {
          edge: "bottom",
          content: <InsetBar title="Bottom Inset" detail="safeAreaInset(bottom)" compact />,
        },
      ]}
    >
      <DemoSection
        title="Stacks And Spacer"
        detail="Natural and fill-equally distributions, alignment, spacing, padding, and onAppear."
      >
        <Card title="VStack / HStack / Spacer" detail={`onAppear fired ${appearCount} times`}>
          <VStack
            alignment="leading"
            spacing={space.md}
            background="secondarySystemBackground"
            cornerRadius={18}
            padding={space.md}
            onAppear={() => setAppearCount((count) => count + 1)}
          >
            <Text font="headline">Natural</Text>
            <HStack spacing={space.sm}>
              <Pill text="Leading" />
              <Spacer />
              <Pill text="Trailing" />
            </HStack>
            <Text font="headline">Fill Equally</Text>
            <HStack distribution="fillEqually" spacing={space.sm}>
              <ValuePlate title="A" detail="maxWidth" />
              <ValuePlate title="B" detail="maxWidth" />
              <ValuePlate title="C" detail="maxWidth" />
            </HStack>
          </VStack>
        </Card>
      </DemoSection>

      <DemoSection title="Adaptive Layouts" detail="ViewThatFits, Grid, FlowLayout, GeometryReader, and CustomLayout.">
        <Card title="ViewThatFits" detail="Horizontal and vertical selection.">
          <ViewThatFits axis="horizontal">
            <HStack spacing={space.sm}>
              <Pill text="Compact" />
              <Pill text="Horizontal" />
              <Pill text="Choice" />
            </HStack>
            <VStack alignment="leading" spacing={space.xs}>
              <Pill text="Falls back" />
              <Pill text="to vertical" />
            </VStack>
          </ViewThatFits>
        </Card>

        <Card title="Grid">
          <Grid horizontalSpacing={space.sm} verticalSpacing={space.sm}>
            <GridRow>
              <ValuePlate title="1" detail="Top leading" />
              <ValuePlate title="2" detail="Top trailing" />
            </GridRow>
            <GridRow>
              <ValuePlate title="3" detail="Bottom leading" />
              <ValuePlate title="4" detail="Bottom trailing" />
            </GridRow>
          </Grid>
        </Card>

        <Card title="FlowLayout">
          <FlowLayout spacing={space.sm} lineSpacing={space.sm}>
            {["Capsule", "Grid", "List", "Toolbar", "Sheet", "Glass", "Form", "Menu"].map((label) => (
              <Text key={label} background="tertiarySystemBackground" cornerRadius={999} padding={space.sm} lineLimit={1} minimumScaleFactor={0.8}>
                {label}
              </Text>
            ))}
          </FlowLayout>
        </Card>

        <Card title="GeometryReader" detail="The child closure sees live geometry size.">
          <GeometryReader frame={{ height: 120 }}>
            {(proxy) => (
              <ZStack frame={{ maxWidth: "infinity", maxHeight: "infinity" }} background="tertiarySystemBackground" cornerRadius={18}>
                <RoundedRectangle
                  cornerRadius={18}
                  fill={{
                    type: "LinearGradient",
                    colors: ["blue", "mint"],
                    startPoint: "topLeading",
                    endPoint: "bottomTrailing",
                  }}
                  frame={{ maxWidth: "infinity", maxHeight: "infinity" }}
                />
                <Text font="headline" foregroundColor="white">
                  {`${Math.round(proxy.size.width)} × ${Math.round(proxy.size.height)}`}
                </Text>
              </ZStack>
            )}
          </GeometryReader>
        </Card>

        <Card title="CustomLayout" detail="JS measures and places subviews through the layout bridge.">
          <CatalogOrbitLayout frame={{ height: 180 }} background="secondarySystemBackground" cornerRadius={18}>
            <Pill text="Alpha" />
            <Pill text="Beta" />
            <Pill text="Gamma" />
            <Pill text="Delta" />
            <Pill text="Epsilon" />
          </CatalogOrbitLayout>
        </Card>
      </DemoSection>

      <DemoSection title="Scroll And Safe Areas" detail="safeAreaPadding, ignoresSafeArea, aspectRatio, and frame options.">
        <Card title="Safe Area Padding">
          <VStack
            safeAreaPadding={{ edges: "horizontal", length: 12 }}
            background="secondarySystemBackground"
            cornerRadius={18}
            padding={space.md}
            spacing={space.sm}
          >
            <Text font="headline">safeAreaPadding(horizontal, 12)</Text>
            <Text foregroundColor="secondary">Interactive content stays inset while the screen background can still run edge-to-edge.</Text>
          </VStack>
        </Card>

        <Card title="Ignore Safe Area Edges">
          <LinearGradient
            colors={["indigo", "blue", "cyan"]}
            startPoint="topLeading"
            endPoint="bottomTrailing"
            frame={{ height: 120, maxWidth: "infinity" }}
            ignoresSafeArea={{ edges: "horizontal" }}
            cornerRadius={18}
          />
        </Card>

        <Card title="Aspect Ratio">
          <HStack spacing={space.md} alignment="top">
            <Image
              name="CatalogMark"
              resizable
              frame={{ width: 72, height: 72 }}
              aspectRatio={1}
              imageContentMode="fit"
              interpolation="none"
              background="tertiarySystemBackground"
              cornerRadius={12}
            />
            <Image
              name="CatalogMark"
              resizable
              frame={{ width: 72, height: 72 }}
              aspectRatio={{ value: 1, contentMode: "fill" }}
              interpolation="high"
              background="tertiarySystemBackground"
              cornerRadius={12}
            />
          </HStack>
        </Card>
      </DemoSection>

      <DemoSection title="Navigation" detail="Regular stack navigation keeps the catalog simpler on iPhone.">
        <Card title="Stack Links">
          <VStack alignment="leading" spacing={space.sm}>
            <NavigationLink
              destination={
                <VStack
                  frame={{ maxWidth: "infinity" }}
                  alignment="leading"
                  spacing={space.sm}
                  background="secondarySystemBackground"
                  cornerRadius={18}
                  padding={space.md}
                >
                  <Text font="headline">Overview</Text>
                  <Text foregroundColor="secondary">Simple pushed detail content.</Text>
                </VStack>
              }
            >
              <Label title="Overview" systemName="square.grid.2x2" />
            </NavigationLink>
            <NavigationLink
              destination={
                <VStack
                  frame={{ maxWidth: "infinity" }}
                  alignment="leading"
                  spacing={space.sm}
                  background="secondarySystemBackground"
                  cornerRadius={18}
                  padding={space.md}
                >
                  <Text font="headline">Pinned</Text>
                  <Text foregroundColor="secondary">Pushed detail screens are easier to inspect in the sample app.</Text>
                </VStack>
              }
            >
              <Label title="Pinned" systemName="pin" />
            </NavigationLink>
            <NavigationLink
              destination={
                <VStack
                  frame={{ maxWidth: "infinity" }}
                  alignment="leading"
                  spacing={space.sm}
                  background="secondarySystemBackground"
                  cornerRadius={18}
                  padding={space.md}
                >
                  <Text font="headline">Recent</Text>
                  <Text foregroundColor="secondary">No collapsed split behavior to reason about.</Text>
                </VStack>
              }
            >
              <Label title="Recent" systemName="clock" />
            </NavigationLink>
          </VStack>
        </Card>
      </DemoSection>

    </ScreenShell>
  )
}
