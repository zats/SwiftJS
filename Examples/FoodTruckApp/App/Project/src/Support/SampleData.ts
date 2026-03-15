export type CorePanel = "truck" | "orders" | "socialFeed" | "salesHistory" | "donuts" | "donutEditor" | "topFive"
export type CityID = "san-francisco" | "cupertino" | "new-york"
export type Panel = CorePanel | `city:${CityID}`

export type DonutOption = {
  id: string
  name: string
  thumb: string
  full: string
}

export type DonutRecipe = {
  id: string
  name: string
  dough: DonutOption
  glaze: DonutOption
  topping: DonutOption
  sales: string
}

export type OrderStatus = "New" | "Preparing" | "Ready" | "Completed"

export type Order = {
  id: string
  customer: string
  city: string
  donuts: DonutRecipe[]
  total: string
  status: OrderStatus
}

export type CityInfo = {
  id: CityID
  name: string
  forecast: string
  temperature: string
  cloudCover: string
  recommendation: string
}

export type TruckWeatherForecastEntry = {
  date: Date
  degrees: number
  isDaylight: boolean
}

export type TruckWeatherForecast = {
  entries: TruckWeatherForecastEntry[]
}

export const doughOptions: DonutOption[] = [
  { id: "plain", name: "Plain", thumb: "dough/plain-thumb", full: "dough/plain-full" },
  { id: "pink", name: "Pink", thumb: "dough/pink-thumb", full: "dough/pink-full" },
  { id: "blue", name: "Blue", thumb: "dough/blue-thumb", full: "dough/blue-full" },
  { id: "yellow", name: "Yellow", thumb: "dough/yellow-thumb", full: "dough/yellow-full" },
]

export const glazeOptions: DonutOption[] = [
  { id: "pink", name: "Strawberry", thumb: "glaze/pink-thumb", full: "glaze/pink-full" },
  { id: "blue", name: "Blueberry", thumb: "glaze/blue-thumb", full: "glaze/blue-full" },
  { id: "brown", name: "Chocolate", thumb: "glaze/brown-thumb", full: "glaze/brown-full" },
  { id: "rainbow", name: "Rainbow", thumb: "glaze/rainbow-thumb", full: "glaze/rainbow-full" },
]

export const toppingOptions: DonutOption[] = [
  { id: "sprinkles", name: "Sprinkles", thumb: "topping/sprinkles-thumb", full: "topping/sprinkles-full" },
  { id: "powdersugar", name: "Powder Sugar", thumb: "topping/powdersugar-thumb", full: "topping/powdersugar-full" },
  { id: "zigzag-white", name: "White Zigzag", thumb: "topping/zigzag-white-thumb", full: "topping/zigzag-white-full" },
  { id: "crisscross-yellow", name: "Yellow Crisscross", thumb: "topping/crisscross-yellow-thumb", full: "topping/crisscross-yellow-full" },
]

export const donutCatalog: DonutRecipe[] = [
  {
    id: "strawberry-sprinkles",
    name: "Strawberry Sprinkles",
    dough: doughOptions[0],
    glaze: glazeOptions[0],
    topping: toppingOptions[0],
    sales: "$5.4K",
  },
  {
    id: "blue-sky",
    name: "Blue Sky",
    dough: doughOptions[2],
    glaze: glazeOptions[1],
    topping: toppingOptions[2],
    sales: "$4.9K",
  },
  {
    id: "powder-party",
    name: "Powder Party",
    dough: doughOptions[3],
    glaze: glazeOptions[3],
    topping: toppingOptions[1],
    sales: "$4.6K",
  },
  {
    id: "sunrise-grid",
    name: "Sunrise Grid",
    dough: doughOptions[1],
    glaze: glazeOptions[2],
    topping: toppingOptions[3],
    sales: "$4.1K",
  },
  {
    id: "rainbow-rally",
    name: "Rainbow Rally",
    dough: doughOptions[0],
    glaze: glazeOptions[3],
    topping: toppingOptions[0],
    sales: "$3.8K",
  },
]

export const orders: Order[] = [
  {
    id: "Order #4021",
    customer: "Mina R.",
    city: "San Francisco",
    donuts: [donutCatalog[1], donutCatalog[4], donutCatalog[0]],
    total: "$118",
    status: "New",
  },
  {
    id: "Order #4020",
    customer: "A. Chen",
    city: "Cupertino",
    donuts: [donutCatalog[3], donutCatalog[2]],
    total: "$72",
    status: "New",
  },
  {
    id: "Order #4017",
    customer: "Studio Lune",
    city: "New York",
    donuts: [donutCatalog[4], donutCatalog[1], donutCatalog[2]],
    total: "$164",
    status: "Preparing",
  },
  {
    id: "Order #4015",
    customer: "River Team",
    city: "San Francisco",
    donuts: [donutCatalog[0]],
    total: "$54",
    status: "Preparing",
  },
  {
    id: "Order #4012",
    customer: "Nora W.",
    city: "Cupertino",
    donuts: [donutCatalog[2], donutCatalog[3]],
    total: "$92",
    status: "Ready",
  },
  {
    id: "Order #4008",
    customer: "Beacon Labs",
    city: "New York",
    donuts: [donutCatalog[1], donutCatalog[0], donutCatalog[4], donutCatalog[2]],
    total: "$188",
    status: "Completed",
  },
]

export const socialPosts = [
  { id: "post-1", title: "Today’s route: Ocean Beach to SoMa", subtitle: "Warm donuts, black raspberry glaze, and a new citrus topping." },
  { id: "post-2", title: "The social feed card is now real SwiftJS UI", subtitle: "Same content model, new reusable host bindings under it." },
  { id: "post-3", title: "Most requested combo this week", subtitle: "Rainbow glaze with powdered sugar and a plain dough base." },
]

export const trendingTopics = [
  "Rainbow Sprinkles",
  "Room Temperature",
  "Dairy Free",
  "Cupertino",
  "Warmed Up",
  "Black Raspberry",
]

export const cities: CityInfo[] = [
  {
    id: "san-francisco",
    name: "San Francisco",
    forecast: "Sunny for the lunch rush, cool after 4 PM.",
    temperature: "68°F",
    cloudCover: "12%",
    recommendation: "Keep the truck near Embarcadero. Strong foot traffic and low rain chance through the afternoon.",
  },
  {
    id: "cupertino",
    name: "Cupertino",
    forecast: "Clear and warm through the late afternoon.",
    temperature: "74°F",
    cloudCover: "9%",
    recommendation: "Stock bright fruit glazes and cold ingredients. Campus traffic peaks around 3 PM.",
  },
  {
    id: "new-york",
    name: "New York",
    forecast: "Patchy clouds with a mild evening cooldown.",
    temperature: "71°F",
    cloudCover: "28%",
    recommendation: "Favor Midtown for the next stop. Office volume is high and rain holds off until tonight.",
  },
]

function forecastEntry(hourOffset: number, degrees: number, isDaylight: boolean): TruckWeatherForecastEntry {
  return {
    date: new Date(Date.UTC(2022, 4, 6, 9 + hourOffset)),
    degrees,
    isDaylight,
  }
}

export const truckForecast: TruckWeatherForecast = {
  entries: [
    forecastEntry(0, 63, true),
    forecastEntry(1, 68, true),
    forecastEntry(2, 72, true),
    forecastEntry(3, 77, true),
    forecastEntry(4, 80, true),
    forecastEntry(5, 82, true),
    forecastEntry(6, 83, true),
    forecastEntry(7, 83, true),
    forecastEntry(8, 81, true),
    forecastEntry(9, 79, true),
    forecastEntry(10, 75, true),
    forecastEntry(11, 70, true),
    forecastEntry(12, 66, false),
  ],
}

export const truckShowcaseDonuts: DonutRecipe[] = [
  donutCatalog[0],
  donutCatalog[1],
  donutCatalog[2],
  donutCatalog[3],
  donutCatalog[4],
  donutCatalog[1],
  donutCatalog[3],
  donutCatalog[0],
  donutCatalog[2],
  donutCatalog[4],
  donutCatalog[0],
  donutCatalog[2],
  donutCatalog[3],
  donutCatalog[1],
]

export const donutPanels = [
  { panel: "donuts" as const, title: "Donuts", icon: "donut" },
  { panel: "donutEditor" as const, title: "Donut Editor", icon: "slider.horizontal.3" },
  { panel: "topFive" as const, title: "Top 5", icon: "trophy" },
]

export function cityPanel(id: CityID): Panel {
  return `city:${id}`
}

export function formatForecastHour(date: Date) {
  const hour = date.getUTCHours()
  const normalizedHour = ((hour + 11) % 12) + 1
  const suffix = hour >= 12 ? "PM" : "AM"
  return `${normalizedHour} ${suffix}`
}
