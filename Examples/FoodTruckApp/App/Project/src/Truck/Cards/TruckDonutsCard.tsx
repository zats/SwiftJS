import { CustomLayout, Label, VStack, type LayoutBounds, type LayoutSubview, type ProposedViewSize } from "../../swiftjs"
import { DonutView } from "../../Donut/DonutView"
import type { DonutRecipe, Panel } from "../../Support/SampleData"
import { CardNavigationHeader } from "./CardNavigationHeader"

const defaultAxesSize = {
  width: Number.MAX_VALUE,
  height: Number.MAX_VALUE,
} as const

export function TruckDonutsCard(props: { donuts: DonutRecipe[]; onSelect: (panel: Panel) => void }) {
  return (
    <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader onSelect={() => props.onSelect("donuts")}>
        <Label title="Donuts" name="donut" font="headline" fontWeight="semibold" foregroundColor="indigo" />
      </CardNavigationHeader>

      <DonutLatticeLayout>
        {props.donuts.slice(0, 14).map((donut) => (
          <DonutView key={donut.id} donut={donut} />
        ))}
      </DonutLatticeLayout>
    </VStack>
  )
}

function DonutLatticeLayout(props: { children?: unknown }) {
  return (
    <CustomLayout
      name="DonutLatticeLayout"
      frame={{ minHeight: 180, maxHeight: "infinity" }}
      sizeThatFits={sizeThatFits}
      placeSubviews={placeSubviews}
    >
      {props.children}
    </CustomLayout>
  )
}

function sizeThatFits(proposal: ProposedViewSize, _subviews: LayoutSubview[]) {
  const columns = 5
  const rows = 3
  const size = proposal.replacingUnspecifiedDimensions(defaultAxesSize)
  const cellLength = Math.min(size.width / columns, size.height / rows)

  return {
    width: cellLength * columns,
    height: cellLength * rows,
  }
}

function placeSubviews(bounds: LayoutBounds, proposal: ProposedViewSize, subviews: LayoutSubview[]) {
  const columns = 5
  const rows = 3
  const spacing = 10
  const size = proposal.replacingUnspecifiedDimensions(defaultAxesSize)
  const cellLength = Math.min(size.width / columns, size.height / rows)
  const rectSize = {
    width: cellLength * columns,
    height: cellLength * rows,
  }
  const origin = {
    x: bounds.minX + (bounds.width - rectSize.width),
    y: bounds.minY + (bounds.height - rectSize.height),
  }
  const placements = []

  for (let row = 0; row < rows; row += 1) {
    const cellY = origin.y + cellLength * row
    const columnsForRow = row % 2 === 0 ? columns : columns - 1

    for (let column = 0; column < columnsForRow; column += 1) {
      let cellX = origin.x + cellLength * column
      if (row % 2 !== 0) {
        cellX += cellLength * 0.5
      }

      let index = column
      for (let completedRow = 0; completedRow < row; completedRow += 1) {
        index += completedRow % 2 === 0 ? columns : columns - 1
      }

      if (index >= subviews.length) {
        break
      }

      placements.push({
        x: cellX + spacing * 0.5,
        y: cellY + spacing * 0.5,
        anchor: "topLeading" as const,
        width: cellLength - spacing,
        height: cellLength - spacing,
      })
    }
  }

  return placements
}
