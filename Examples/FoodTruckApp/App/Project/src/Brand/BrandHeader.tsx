import { CustomHost } from "../General/CustomHost"

type HeaderSize = "standard" | "reduced"

export function BrandHeader(props: { animated?: boolean; size?: HeaderSize }) {
  return (
    <CustomHost
      name="BrandHeader"
      values={{
        animated: props.animated ?? true,
        size: props.size ?? "standard",
      }}
    />
  )
}
