import { CustomHost } from "./CustomHost"

type WidthThresholdReaderProxy = {
  width: number
  isCompact: boolean
}

export function WidthThresholdReader(props: {
  widthThreshold?: number
  children: ((proxy: WidthThresholdReaderProxy) => unknown) | Array<(proxy: WidthThresholdReaderProxy) => unknown>
}) {
  const widthThreshold = props.widthThreshold ?? 400
  const content = Array.isArray(props.children) ? props.children[0] : props.children

  if (typeof content !== "function") {
    throw new Error("WidthThresholdReader requires a render function child")
  }

  return (
    <CustomHost
      name="WidthThresholdReader"
      values={{
        widthThreshold,
      }}
      slots={{
        compact: content({ width: widthThreshold - 1, isCompact: true }),
        regular: content({ width: widthThreshold + 1, isCompact: false }),
      }}
    />
  )
}
