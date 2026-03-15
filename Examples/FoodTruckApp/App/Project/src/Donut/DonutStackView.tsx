import type { ViewProps } from "../swiftjs"
import type { DonutRecipe } from "../Support/SampleData"
import { DiagonalDonutStackLayout } from "./DiagonalDonutStackLayout"
import { DonutView } from "./DonutView"

export function DonutStackView(props: { donuts: DonutRecipe[]; includeOverflowCount?: boolean } & ViewProps) {
  return (
    <DiagonalDonutStackLayout
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
    >
      {props.donuts.slice(0, 3).map((donut) => (
        <DonutView key={donut.id} donut={donut} />
      ))}
    </DiagonalDonutStackLayout>
  )
}
