import { HStack, Image, Spacer, Text, VStack } from "../../swiftjs"
import { donutCatalog, orders } from "../../Support/SampleData"
import type { DonutRecipe, Order } from "../../Support/SampleData"
import type { Panel } from "../../Support/SampleData"
import { DonutPreview } from "../../Support/DonutComponents"
import { CardNavigationHeader } from "./CardNavigationHeader"

export function TruckOrdersCard(props: { onSelect: (panel: Panel) => void }) {
  const cardOrders = orders.slice().reverse().slice(0, 5)
  const footerOrder = orders[orders.length - 1]

  return (
    <VStack id="truck-orders-card" alignment="leading" spacing={12} padding={10} background="white" cornerRadius={20}>
      <CardNavigationHeader
        id="truck-orders-card-header"
        panel="orders"
        title="New Orders"
        systemName="shippingbox"
        onSelect={() => props.onSelect("orders")}
      />

      <HeroSquareTilingLayout id="truck-orders-card-media">
        {cardOrders.map((order, index) => (
          <OrderPreviewTile
            key={order.id}
            order={order}
            recipe={donutCatalog[index % donutCatalog.length]}
            prominent={index === 0}
          />
        ))}
      </HeroSquareTilingLayout>

      <HStack id="truck-orders-card-footer" spacing={8} frame={{ maxWidth: "infinity" }}>
        <Spacer id="truck-orders-card-footer-leading" />
        <Text id="truck-orders-card-order-id" font="subheadline" foregroundColor="secondary">
          {footerOrder.id}
        </Text>
        <Image id="truck-orders-card-order-icon" name="donut" frame={{ width: 14, height: 14 }} />
        <Text id="truck-orders-card-order-total" font="subheadline" foregroundColor="secondary">
          {footerOrder.total}
        </Text>
        <Spacer id="truck-orders-card-footer-trailing" />
      </HStack>
    </VStack>
  )
}

function HeroSquareTilingLayout(props: { id: string; spacing?: number; children?: unknown }) {
  const spacing = props.spacing ?? 10
  const [hero, tile1, tile2, tile3, tile4] = flattenChildren(props.children)

  return (
    <VStack id={props.id} frame={{ maxWidth: "infinity", maxHeight: 250 }} aspectRatio={{ value: 2, contentMode: "fit" }}>
      <HStack id={`${props.id}-content`} spacing={spacing} distribution="fillEqually">
        <VStack id={`${props.id}-hero`} aspectRatio={{ value: 1, contentMode: "fit" }}>
          {hero}
        </VStack>
        <VStack id={`${props.id}-tiles`} spacing={spacing} distribution="fillEqually">
          <HStack id={`${props.id}-tiles-top`} spacing={spacing} distribution="fillEqually">
            <VStack id={`${props.id}-tiles-top-left`} aspectRatio={{ value: 1, contentMode: "fit" }}>
              {tile1}
            </VStack>
            <VStack id={`${props.id}-tiles-top-right`} aspectRatio={{ value: 1, contentMode: "fit" }}>
              {tile2}
            </VStack>
          </HStack>
          <HStack id={`${props.id}-tiles-bottom`} spacing={spacing} distribution="fillEqually">
            <VStack id={`${props.id}-tiles-bottom-left`} aspectRatio={{ value: 1, contentMode: "fit" }}>
              {tile3}
            </VStack>
            <VStack id={`${props.id}-tiles-bottom-right`} aspectRatio={{ value: 1, contentMode: "fit" }}>
              {tile4}
            </VStack>
          </HStack>
        </VStack>
      </HStack>
    </VStack>
  )
}

function flattenChildren(children: unknown): unknown[] {
  if (!Array.isArray(children)) {
    return children === undefined || children === null || children === false ? [] : [children]
  }

  return children.flatMap((child) => flattenChildren(child))
}

function OrderPreviewTile(props: { order: Order; recipe: DonutRecipe; prominent?: boolean }) {
  return (
    <VStack
      id={`order-tile-${props.order.id}`}
      alignment="center"
      spacing={0}
      padding={6}
      background="tertiarySystemFill"
      cornerRadius={10}
      aspectRatio={{ value: 1, contentMode: "fit" }}
    >
      <DonutPreview recipe={props.recipe} size={props.prominent ? "featured" : "mini"} />
    </VStack>
  )
}
