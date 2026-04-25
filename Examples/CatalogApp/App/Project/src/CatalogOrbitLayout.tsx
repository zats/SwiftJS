import {
  CustomLayout,
  type LayoutBounds,
  type LayoutSubview,
  type ProposedViewSize,
  type ViewProps,
} from "swiftjs"

const fallbackSize = { width: 72, height: 72 } as const

export function CatalogOrbitLayout(props: { children?: unknown } & ViewProps) {
  return (
    <CustomLayout
      name="CatalogOrbitLayout"
      padding={props.padding}
      paddingTop={props.paddingTop}
      frame={props.frame}
      alignment={props.alignment}
      background={props.background}
      foregroundColor={props.foregroundColor}
      foregroundStyle={props.foregroundStyle}
      tint={props.tint}
      cornerRadius={props.cornerRadius}
      imageContentMode={props.imageContentMode}
      aspectRatio={props.aspectRatio}
      fixedSize={props.fixedSize}
      safeAreaPadding={props.safeAreaPadding}
      ignoresSafeArea={props.ignoresSafeArea}
      safeAreaInset={props.safeAreaInset}
      symbolRenderingMode={props.symbolRenderingMode}
      buttonStyle={props.buttonStyle}
      buttonBorderShape={props.buttonBorderShape}
      disabled={props.disabled}
      glassEffect={props.glassEffect}
      lineLimit={props.lineLimit}
      multilineTextAlignment={props.multilineTextAlignment}
      truncationMode={props.truncationMode}
      minimumScaleFactor={props.minimumScaleFactor}
      onAppear={props.onAppear}
      sizeThatFits={sizeThatFits}
      placeSubviews={placeSubviews}
    >
      {props.children}
    </CustomLayout>
  )
}

function sizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubview[]) {
  const replaced = proposal.replacingUnspecifiedDimensions(fallbackSize)
  const side = Math.max(140, Math.min(replaced.width, 240))
  const layers = Math.max(1, subviews.length)
  return {
    width: side,
    height: side * (layers > 4 ? 0.9 : 0.8),
  }
}

function placeSubviews(bounds: LayoutBounds, proposal: ProposedViewSize, subviews: LayoutSubview[]) {
  const replaced = proposal.replacingUnspecifiedDimensions(fallbackSize)
  const side = Math.max(140, Math.min(Math.min(bounds.width, replaced.width), 240))
  const centerX = bounds.minX + bounds.width * 0.5
  const centerY = bounds.minY + bounds.height * 0.5
  const radiusX = side * 0.28
  const radiusY = side * 0.18

  return subviews.map((subview, index) => {
    const measured = subview.sizeThatFits({ width: side * 0.36, height: side * 0.24 })
    const count = Math.max(1, subviews.length)
    const angle = (Math.PI * 2 * index) / count - Math.PI / 2
    return {
      x: centerX + Math.cos(angle) * radiusX,
      y: centerY + Math.sin(angle) * radiusY,
      anchor: "center" as const,
      width: measured.width ?? side * 0.34,
      height: measured.height ?? side * 0.18,
    }
  })
}
