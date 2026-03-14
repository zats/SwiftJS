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
    <ZStack id={`preview-${props.recipe.id}-${props.size}`} frame={{ width: imageSize, height: imageSize }}>
      <Image id={`preview-dough-${props.recipe.id}-${props.size}`} name={dough} frame={{ width: imageSize, height: imageSize }} />
      <Image id={`preview-glaze-${props.recipe.id}-${props.size}`} name={glaze} frame={{ width: imageSize, height: imageSize }} />
      <Image id={`preview-topping-${props.recipe.id}-${props.size}`} name={topping} frame={{ width: imageSize, height: imageSize }} />
    </ZStack>
  )
}

export function DonutThumbnail(props: { recipe: DonutRecipe }) {
  return (
    <VStack id={`thumb-${props.recipe.id}`} alignment="center" spacing={6}>
      <DonutPreview recipe={props.recipe} size="thumb" />
      <Text id={`thumb-title-${props.recipe.id}`} font="footnote" foregroundColor="secondary">
        {props.recipe.name}
      </Text>
    </VStack>
  )
}

export function GalleryTile(props: { recipe: DonutRecipe }) {
  return (
    <VStack
      id={`gallery-tile-${props.recipe.id}`}
      alignment="center"
      spacing={8}
      padding={12}
      background="secondarySystemBackground"
      cornerRadius={18}
    >
      <DonutPreview recipe={props.recipe} size="thumb" />
      <Text id={`gallery-name-${props.recipe.id}`} font="subheadline" fontWeight="semibold">
        {props.recipe.name}
      </Text>
      <Text id={`gallery-sales-${props.recipe.id}`} font="footnote" foregroundColor="secondary">
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
    <VStack id={`editor-section-${props.title}`} alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <HStack id={`editor-section-header-${props.title}`} spacing={8}>
        <Image id={`editor-section-icon-${props.title}`} systemName="slider.horizontal.3" foregroundColor="indigo" />
        <Text id={`editor-section-title-${props.title}`} font="headline" fontWeight="semibold" foregroundColor="indigo">
          {props.title}
        </Text>
      </HStack>
      <HStack id={`editor-options-${props.title}`} spacing={10} compactVertical>
        {props.options.map((option, index) => (
          <Button
            id={`editor-option-${props.title}-${option.id}`}
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
