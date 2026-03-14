import type { Panel } from "../Support/SampleData"
import { cityPanel, cities } from "../Support/SampleData"
import { CityView } from "../City/CityView"
import { DonutEditor } from "../Donut/DonutEditor"
import { DonutGallery } from "../Donut/DonutGallery"
import { TopFiveDonutsView } from "../Donut/TopFiveDonutsView"
import { OrdersView } from "../Orders/OrdersView"
import { SalesHistoryView } from "../Truck/SalesHistoryView"
import { SocialFeedView } from "../Truck/SocialFeedView"
import { TruckView } from "../Truck/TruckView"

export function DetailColumn(props: { selection: Panel; onSelect: (panel: Panel) => void }) {
  if (props.selection === "truck") {
    return <TruckView onSelect={props.onSelect} />
  }

  if (props.selection === "orders") {
    return <OrdersView />
  }

  if (props.selection === "socialFeed") {
    return <SocialFeedView />
  }

  if (props.selection === "salesHistory") {
    return <SalesHistoryView />
  }

  if (props.selection === "donuts") {
    return <DonutGallery onSelect={props.onSelect} />
  }

  if (props.selection === "donutEditor") {
    return <DonutEditor />
  }

  if (props.selection === "topFive") {
    return <TopFiveDonutsView />
  }

  if (props.selection.startsWith("city:")) {
    const city = cities.find((entry) => cityPanel(entry.id) === props.selection) ?? cities[0]
    return <CityView city={city} />
  }

  return <TruckView onSelect={props.onSelect} />
}
