import { HStack, Image, List, Section, Spacer, Text, VStack } from "../swiftjs"
import { orders } from "../Support/SampleData"
import type { OrderStatus } from "../Support/SampleData"

export function OrdersView() {
  const statuses: OrderStatus[] = ["New", "Preparing", "Ready", "Completed"]

  return (
    <List id="orders-view" navigationTitle="Orders" listStyle="insetGrouped">
      {statuses.map((status) => {
        const sectionOrders = orders.filter((order) => order.status === status)
        if (sectionOrders.length === 0) {
          return null
        }

        return (
          <Section id={`orders-section-${status}`} key={status} title={status}>
            {sectionOrders.map((order) => (
              <VStack id={`order-${order.id}`} key={order.id} alignment="leading" spacing={4} padding={4}>
                <HStack id={`order-header-${order.id}`} spacing={8}>
                  <Text id={`order-title-${order.id}`} font="headline" fontWeight="semibold">
                    {order.id}
                  </Text>
                  <Spacer id={`order-spacer-${order.id}`} />
                  <Text id={`order-total-${order.id}`} font="subheadline" fontWeight="bold">
                    {order.total}
                  </Text>
                </HStack>
                <Text id={`order-subtitle-${order.id}`} font="subheadline" foregroundColor="secondary">
                  {order.customer} · {order.city} · {order.donuts} donuts
                </Text>
              </VStack>
            ))}
          </Section>
        )
      })}
    </List>
  )
}
