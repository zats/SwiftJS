import { VStack } from "../swiftjs"

type HeaderSize = "standard" | "reduced"

export function BrandHeader(props: { animated?: boolean; size?: HeaderSize }) {
  const scale = props.size === "reduced" ? 0.5 : 1
  const visibleHeight = 200 * scale
  const bleedingHeight = 400 * scale

  return (
    <VStack id="brand-header-root" frame={{ height: visibleHeight }}>
      <VStack
        id="brand-header-canvas"
        background="teal"
        frame={{ height: bleedingHeight }}
        paddingTop={-200 * scale}
      />
    </VStack>
  )
}
