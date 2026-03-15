import { GeometryReader, Image, ZStack } from "../swiftjs"
import type { DonutRecipe } from "../Support/SampleData"

export const donutThumbnailSize = 128

export const DonutLayer = {
  dough: 1 << 1,
  glaze: 1 << 2,
  topping: 1 << 3,
  all: (1 << 1) | (1 << 2) | (1 << 3),
} as const

export function DonutView(props: { donut: DonutRecipe; visibleLayers?: number }) {
  const visibleLayers = props.visibleLayers ?? DonutLayer.all

  return (
    <GeometryReader>
      {(proxy) => {
        const useThumbnail = Math.min(proxy.size.width, proxy.size.height) <= donutThumbnailSize

        return (
          <ZStack
            aspectRatio={{ value: 1, contentMode: "fit" }}
            frame={{ maxWidth: "infinity", maxHeight: "infinity" }}
          >
            {(visibleLayers & DonutLayer.dough) !== 0 ? (
              <Image
                viewID={props.donut.dough.id}
                name={useThumbnail ? props.donut.dough.thumb : props.donut.dough.full}
                imageContentMode="fit"
                interpolation="medium"
              />
            ) : null}

            {(visibleLayers & DonutLayer.glaze) !== 0 ? (
              <Image
                viewID={props.donut.glaze.id}
                name={useThumbnail ? props.donut.glaze.thumb : props.donut.glaze.full}
                imageContentMode="fit"
                interpolation="medium"
              />
            ) : null}

            {(visibleLayers & DonutLayer.topping) !== 0 ? (
              <Image
                viewID={props.donut.topping.id}
                name={useThumbnail ? props.donut.topping.thumb : props.donut.topping.full}
                imageContentMode="fit"
                interpolation="medium"
              />
            ) : null}
          </ZStack>
        )
      }}
    </GeometryReader>
  )
}
