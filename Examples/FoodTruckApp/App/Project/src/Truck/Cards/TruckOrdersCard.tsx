import { CustomLayout, HStack, Image, Label, Spacer, Text, VStack } from "../../swiftjs"
import { DonutStackView } from "../../Donut/DonutStackView"
import { orders } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckOrdersCard(props: { onSelect: (panel: Panel) => void }) {
  const cardOrders = orders.slice().reverse().slice(0, 5)
  const footerOrder = orders[orders.length - 1]

  return (
    <VStack alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader onSelect={() => props.onSelect("orders")}>
        <Label title="New Orders" systemName="shippingbox" font="headline" fontWeight="semibold" foregroundColor="indigo" />
      </CardNavigationHeader>

      <HeroSquareTilingLayout aspectRatio={2} frame={{ maxWidth: "infinity", maxHeight: 250 }}>
        {cardOrders.map((order) => (
          <DonutStackView
            key={order.id}
            donuts={order.donuts}
            padding={6}
            background="tertiarySystemFill"
            cornerRadius={10}
            aspectRatio={{ value: 1, contentMode: "fit" }}
          />
        ))}
      </HeroSquareTilingLayout>

      <HStack spacing={8} frame={{ maxWidth: "infinity" }}>
        <Spacer />
        <Text font="subheadline" foregroundColor="secondary">
          {footerOrder.id}
        </Text>
        <Image name="donut" frame={{ width: 14, height: 14 }} />
        <Text font="subheadline" foregroundColor="secondary">
          {footerOrder.total}
        </Text>
        <Spacer />
      </HStack>
    </VStack>
  )
}

function HeroSquareTilingLayout(props: { spacing?: number; aspectRatio?: number; frame?: { maxWidth?: number | "infinity"; maxHeight?: number } ; children?: unknown }) {
  return (
    <CustomLayout
      name="HeroSquareTilingLayout"
      values={{ spacing: props.spacing ?? 10 }}
      aspectRatio={props.aspectRatio}
      frame={props.frame}
    >
      {props.children}
    </CustomLayout>
  )
}
