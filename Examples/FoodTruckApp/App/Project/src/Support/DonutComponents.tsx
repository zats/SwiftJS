import { Button, HStack, Image, Text, VStack, ZStack } from "../swiftjs"
import type { DonutOption, DonutRecipe } from "./SampleData"

export function DonutPreview(props: { recipe: DonutRecipe; size: "mini" | "thumb" | "featured" | "card" | "lattice" | "full" }) {
  let imageSize = 72

  if (props.size === "mini") {
    imageSize = 32
  } else if (props.size === "lattice") {
    imageSize = 40
  } else if (props.size === "card") {
    imageSize = 48
  } else if (props.size === "featured") {
    imageSize = 84
  } else if (props.size === "full") {
    imageSize = 220
  }

  const dough = props.size === "full" ? props.recipe.dough.full : props.recipe.dough.thumb
  const glaze = props.size === "full" ? props.recipe.glaze.full : props.recipe.glaze.thumb
  const topping = props.size === "full" ? props.recipe.topping.full : props.recipe.topping.thumb

  return (
    <ZStack frame={{ width: imageSize, height: imageSize }}>
      <Image name={dough} frame={{ width: imageSize, height: imageSize }} />
      <Image name={glaze} frame={{ width: imageSize, height: imageSize }} />
      <Image name={topping} frame={{ width: imageSize, height: imageSize }} />
    </ZStack>
  )
}

export function DonutThumbnail(props: { recipe: DonutRecipe }) {
  return (
    <VStack alignment="center" spacing={6}>
      <DonutPreview recipe={props.recipe} size="thumb" />
      <Text font="footnote" foregroundColor="secondary">
        {props.recipe.name}
      </Text>
    </VStack>
  )
}

export function GalleryTile(props: { recipe: DonutRecipe }) {
  return (
    <VStack
      alignment="center"
      spacing={8}
      padding={12}
      background="secondarySystemBackground"
      cornerRadius={18}
    >
      <DonutPreview recipe={props.recipe} size="thumb" />
      <Text font="subheadline" fontWeight="semibold">
        {props.recipe.name}
      </Text>
      <Text font="footnote" foregroundColor="secondary">
        {props.recipe.sales}
      </Text>
    </VStack>
  )
}

export function EditorSection(props: {
  title: string
  options: DonutOption[]
  selectedIndex: number
  onSelect: (index: number) => void
}) {
  return (
    <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <HStack spacing={8}>
        <Image systemName="slider.horizontal.3" foregroundColor="indigo" />
        <Text font="headline" fontWeight="semibold" foregroundColor="indigo">
          {props.title}
        </Text>
      </HStack>
      <HStack spacing={10} compactVertical>
        {props.options.map((option, index) => (
          <Button
            key={option.id}
            action={() => props.onSelect(index)}
            buttonStyle={props.selectedIndex === index ? "borderedProminent" : "bordered"}
            buttonBorderShape="roundedRectangle"
          >
            {option.name}
          </Button>
        ))}
      </HStack>
    </VStack>
  )
}
