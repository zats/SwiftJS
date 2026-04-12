import {
  AngularGradient,
  Capsule,
  Circle,
  Ellipse,
  Grid,
  GridRow,
  HStack,
  Image,
  Label,
  LinearGradient,
  RadialGradient,
  Rectangle,
  RoundedRectangle,
  Text,
  VStack,
} from "../../swiftjs"
import { Card, DemoSection, FixedText, ScreenShell } from "../components/common"
import { space, truncationModes } from "../shared"
import { visualsToolbar } from "../toolbars"

export function VisualsTab() {
  return (
    <ScreenShell title="Visuals" toolbar={visualsToolbar} toolbarBackgroundVisibility="visible" toolbarColorScheme="light">
      <DemoSection title="Text" detail="Fonts, weights, lineLimit, truncationMode, minimumScaleFactor, alignment, and foreground styling.">
        <Card title="Type Scale">
          <VStack spacing={space.xs} alignment="leading">
            <Text font="largeTitle">Large Title</Text>
            <Text font="title">Title</Text>
            <Text font="title2">Title 2</Text>
            <Text font="title3">Title 3</Text>
            <Text font="headline">Headline</Text>
            <Text font="body">Body</Text>
            <Text font="callout">Callout</Text>
            <Text font="caption">Caption</Text>
            <Text font="caption2">Caption 2</Text>
          </VStack>
        </Card>

        <Card title="Weights And Foreground Styles">
          <VStack spacing={space.xs} alignment="leading">
            <Text font="headline" fontWeight="ultraLight">Ultra Light</Text>
            <Text font="headline" fontWeight="regular">Regular</Text>
            <Text font="headline" fontWeight="semibold">Semibold</Text>
            <Text font="headline" fontWeight="black">Black</Text>
            <Text
              font="title2"
              foregroundStyle={{
                type: "LinearGradient",
                colors: ["blue", "purple", "pink"],
                startPoint: "leading",
                endPoint: "trailing",
              }}
            >
              Gradient Foreground
            </Text>
          </VStack>
        </Card>

        <Card title="Line Limit And Truncation">
          <VStack spacing={space.sm} alignment="leading">
            {truncationModes.map((mode) => (
              <Text
                key={mode}
                lineLimit={1}
                truncationMode={mode}
                minimumScaleFactor={0.7}
                frame={{ width: 220 }}
                background="tertiarySystemBackground"
                cornerRadius={10}
                padding={space.sm}
              >
                {`${mode.toUpperCase()} — SwiftUI APIs should stay faithful even in JS authoring.`}
              </Text>
            ))}
            <Text
              lineLimit={2}
              multilineTextAlignment="center"
              frame={{ maxWidth: "infinity" }}
              background="tertiarySystemBackground"
              cornerRadius={10}
              padding={space.sm}
            >
              Multiline centered text with a two-line cap and native truncation behavior.
            </Text>
          </VStack>
        </Card>
      </DemoSection>

      <DemoSection title="Images And Labels" detail="System images, asset images, interpolation, symbol rendering modes, and tint.">
        <Card title="Image Sources">
          <HStack spacing={space.md} alignment="top">
            <VStack spacing={space.xs}>
              <Image systemName="paintpalette.fill" font="largeTitle" symbolRenderingMode="multicolor" tint="orange" />
              <Text font="caption">systemName</Text>
            </VStack>
            <VStack spacing={space.xs}>
              <Image name="CatalogMark" frame={{ width: 48, height: 48 }} interpolation="none" background="tertiarySystemBackground" cornerRadius={12} />
              <Text font="caption">asset name</Text>
            </VStack>
            <VStack spacing={space.xs}>
              <Label title="Hierarchical" systemName="circle.hexagongrid.fill" symbolRenderingMode="hierarchical" />
              <Label title="Monochrome" systemName="seal.fill" symbolRenderingMode="monochrome" />
            </VStack>
          </HStack>
        </Card>

        <Card title="Interpolation">
          <HStack spacing={space.sm}>
            {(["none", "low", "medium", "high"] as const).map((interpolation) => (
              <VStack key={interpolation} spacing={space.xs}>
                <Image
                  name="CatalogMark"
                  frame={{ width: 56, height: 56 }}
                  interpolation={interpolation}
                  imageContentMode="fill"
                  background="tertiarySystemBackground"
                  cornerRadius={10}
                />
                <Text font="caption">{interpolation}</Text>
              </VStack>
            ))}
          </HStack>
        </Card>
      </DemoSection>

      <DemoSection title="Shapes And Gradients" detail="Built-in shapes and gradient views.">
        <Card title="Shapes">
          <Grid horizontalSpacing={space.sm} verticalSpacing={space.sm}>
            <GridRow>
              <Rectangle fill="blue" frame={{ width: 64, height: 44 }} cornerRadius={4} />
              <RoundedRectangle cornerRadius={18} fill="mint" frame={{ width: 64, height: 44 }} />
            </GridRow>
            <GridRow>
              <Circle fill="orange" frame={{ width: 44, height: 44 }} />
              <Capsule fill="pink" frame={{ width: 64, height: 44 }} />
            </GridRow>
            <GridRow>
              <Ellipse fill="indigo" frame={{ width: 64, height: 40 }} />
              <RoundedRectangle cornerRadius={18} stroke="primary" lineWidth={2} frame={{ width: 64, height: 44 }} />
            </GridRow>
          </Grid>
        </Card>

        <Card title="Gradient Views">
          <VStack spacing={space.sm}>
            <LinearGradient colors={["mint", "blue"]} startPoint="leading" endPoint="trailing" frame={{ height: 56, maxWidth: "infinity" }} cornerRadius={14} />
            <RadialGradient colors={["yellow", "orange", "red"]} center="center" startRadius={4} endRadius={64} frame={{ height: 56, maxWidth: "infinity" }} cornerRadius={14} />
            <AngularGradient colors={["pink", "purple", "blue", "pink"]} center="center" angle={180} frame={{ height: 56, maxWidth: "infinity" }} cornerRadius={14} />
          </VStack>
        </Card>
      </DemoSection>

      <DemoSection title="Fixed Size" detail="fixedSize(true) and axis-specific fixed sizing.">
        <Card title="Fixed Size Variants">
          <VStack spacing={space.sm} alignment="leading">
            <FixedText title="fixedSize(true)" fixedSize />
            <FixedText title="fixedSize(horizontal)" fixedSize={{ horizontal: true, vertical: false }} />
            <FixedText title="fixedSize(vertical)" fixedSize={{ horizontal: false, vertical: true }} />
          </VStack>
        </Card>
      </DemoSection>
    </ScreenShell>
  )
}
