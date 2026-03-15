import { HStack, Image, List, Section, Spacer, Text, VStack } from "../swiftjs"
import { orders } from "../Support/SampleData"
import type { OrderStatus } from "../Support/SampleData"

export function OrdersView() {
  const statuses: OrderStatus[] = ["New", "Preparing", "Ready", "Completed"]

  return (
    <List navigationTitle="Orders" listStyle="insetGrouped">
      {statuses.map((status) => {
        const sectionOrders = orders.filter((order) => order.status === status)
        if (sectionOrders.length === 0) {
          return null
        }

        return (
          <Section id={`orders-section-${status}`} key={status} title={status}>
            {sectionOrders.map((order) => (
              <VStack id={`order-${order.id}`} key={order.id} alignment="leading" spacing={4} padding={4}>
                <HStack spacing={8}>
                  <Text font="headline" fontWeight="semibold">
                    {order.id}
                  </Text>
                  <Spacer />
                  <Text font="subheadline" fontWeight="bold">
                    {order.total}
                  </Text>
                </HStack>
                <Text font="subheadline" foregroundColor="secondary">
                  {order.customer} · {order.city} · {order.donuts.length} donuts
                </Text>
              </VStack>
            ))}
          </Section>
        )
      })}
    </List>
  )
}
