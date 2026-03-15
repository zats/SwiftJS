import { CustomLayout, type LayoutBounds, type LayoutSubview, type ProposedViewSize, type ViewProps } from "../swiftjs"

const defaultSize = { width: 60, height: 60 } as const

export function DiagonalDonutStackLayout(props: { children?: unknown } & ViewProps) {
  return (
    <CustomLayout
      name="DiagonalDonutStackLayout"
      padding={props.padding}
      paddingTop={props.paddingTop}
      frame={props.frame}
      background={props.background}
      foregroundColor={props.foregroundColor}
      cornerRadius={props.cornerRadius}
      aspectRatio={props.aspectRatio}
      fixedSize={props.fixedSize}
      compactVertical={props.compactVertical}
      symbolRenderingMode={props.symbolRenderingMode}
      buttonStyle={props.buttonStyle}
      buttonBorderShape={props.buttonBorderShape}
      disabled={props.disabled}
      glassEffect={props.glassEffect}
      onAppear={props.onAppear}
      sizeThatFits={sizeThatFits}
      placeSubviews={placeSubviews}
    >
      {props.children}
    </CustomLayout>
  )
}

function sizeThatFits(proposal: ProposedViewSize, _subviews: LayoutSubview[]) {
  const proposalSize = proposal.replacingUnspecifiedDimensions(defaultSize)
  const minBound = Math.min(proposalSize.width, proposalSize.height)
  return { width: minBound, height: minBound }
}

function placeSubviews(bounds: LayoutBounds, proposal: ProposedViewSize, subviews: LayoutSubview[]) {
  const proposalSize = proposal.replacingUnspecifiedDimensions(defaultSize)
  const minBound = Math.min(proposalSize.width, proposalSize.height)
  const size = { width: minBound, height: minBound }
  const rect = {
    minX: bounds.minX + bounds.width - minBound,
    minY: bounds.minY + bounds.height - minBound,
    width: size.width,
    height: size.height,
  }
  const center = { x: rect.minX + rect.width * 0.5, y: rect.minY + rect.height * 0.5 }
  const placements = []
  const count = Math.min(subviews.length, 3)

  for (let index = 0; index < count; index += 1) {
    switch (true) {
      case count === 1:
        placements.push({
          x: center.x,
          y: center.y,
          anchor: "center",
          width: size.width,
          height: size.height,
        })
        break
      case count === 2: {
        const direction = index === 0 ? -1 : 1
        placements.push({
          x: center.x + minBound * direction * 0.15,
          y: center.y + minBound * direction * 0.2,
          anchor: "center",
          width: size.width * 0.7,
          height: size.height * 0.7,
        })
        break
      }
      case index === 1:
        placements.push({
          x: center.x,
          y: center.y,
          anchor: "center",
          width: size.width * 0.65,
          height: size.height * 0.65,
        })
        break
      default: {
        const direction = index === 0 ? -1 : 1
        placements.push({
          x: center.x + minBound * direction * 0.15,
          y: center.y + minBound * direction * 0.23,
          anchor: "center",
          width: size.width * 0.7,
          height: size.height * 0.65,
        })
        break
      }
    }
  }

  return placements
}
