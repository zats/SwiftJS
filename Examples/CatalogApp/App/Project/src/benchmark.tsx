import {
  Button,
  Chart,
  CustomLayout,
  HStack,
  List,
  ScrollView,
  Slider,
  Text,
  TextField,
  Toggle,
  VStack,
  mount,
  useAppStorage,
  useState,
  type ChartPointValue,
  type LayoutBounds,
  type LayoutPlacement,
  type LayoutSubview,
  type ProposedViewSize,
} from "swiftjs"

type BenchmarkCase = "wide-text" | "list" | "controls" | "chart" | "layout-bridge" | "mixed"

type RuntimeWithMetrics = {
  __swiftjsRuntime?: {
    benchmarkMetrics?: () => unknown
  }
}

mount(BenchmarkApp)

function BenchmarkApp() {
  const [caseName] = useAppStorage<BenchmarkCase>("swiftjs.benchmark.case", "wide-text")
  const [size] = useAppStorage<number>("swiftjs.benchmark.size", 600)
  const [tick, setTick] = useState(0)

  return (
    <VStack id="benchmark-root" spacing={8} padding={8} frame={{ maxWidth: "infinity", maxHeight: "infinity" }}>
      <HStack id="benchmark-controls" spacing={8}>
        <Button id="benchmark.tick" action={() => setTick((value) => value + 1)}>
          <Text>Tick {tick}</Text>
        </Button>
        <Button id="benchmark.report" action={reportMetrics}>
          <Text>Report</Text>
        </Button>
      </HStack>
      <BenchmarkSurface caseName={caseName} size={size} tick={tick} />
    </VStack>
  )
}

function BenchmarkSurface(props: { caseName: BenchmarkCase; size: number; tick: number }) {
  switch (props.caseName) {
    case "list":
      return <ListCase size={props.size} tick={props.tick} />
    case "controls":
      return <ControlsCase size={Math.min(props.size, 260)} tick={props.tick} />
    case "chart":
      return <ChartCase size={props.size} tick={props.tick} />
    case "layout-bridge":
      return <LayoutBridgeCase size={Math.min(props.size, 180)} tick={props.tick} />
    case "mixed":
      return <MixedCase size={props.size} tick={props.tick} />
    case "wide-text":
    default:
      return <WideTextCase size={props.size} tick={props.tick} />
  }
}

function WideTextCase(props: { size: number; tick: number }) {
  return (
    <ScrollView id="wide-scroll" frame={{ maxWidth: "infinity", maxHeight: "infinity" }}>
      <VStack id="wide-stack" alignment="leading" spacing={3}>
        {range(props.size).map((index) => (
          <HStack id={`wide-row-${index}`} key={index} spacing={6} padding={3}>
            <Text font="caption" foregroundColor="secondary">
              {index}
            </Text>
            <Text lineLimit={1}>
              {index === props.tick % props.size ? `updated-${props.tick}` : `stable-${index}`}
            </Text>
            <Text foregroundColor={index % 2 === 0 ? "blue" : "green"} lineLimit={1}>
              {`payload-${index}-${props.tick % 7}`}
            </Text>
          </HStack>
        ))}
      </VStack>
    </ScrollView>
  )
}

function ListCase(props: { size: number; tick: number }) {
  const rows = range(props.size).map((index) => ({ id: `row-${index}`, index }))

  return (
    <List listStyle="plain">
      {rows.map((row) => (
        <HStack id={row.id} key={row.id} spacing={8}>
          <Text font="caption" foregroundColor="secondary">
            {row.index}
          </Text>
          <Text lineLimit={1}>{row.index === props.tick % props.size ? `selected ${props.tick}` : `row ${row.index}`}</Text>
        </HStack>
      ))}
    </List>
  )
}

function ControlsCase(props: { size: number; tick: number }) {
  return (
    <ScrollView id="controls-scroll" frame={{ maxWidth: "infinity", maxHeight: "infinity" }}>
      <VStack id="controls-stack" alignment="leading" spacing={6}>
        {range(props.size).map((index) => {
          const value = ((props.tick + index) % 100) / 100
          return (
            <HStack id={`control-row-${index}`} key={index} spacing={8}>
              <TextField title={`Field ${index}`} text={`value-${index}-${props.tick % 31}`} onChange={() => undefined} frame={{ width: 140 }} />
              <Slider value={value} onChange={() => undefined} range={{ start: 0, end: 1 }} frame={{ width: 120 }} />
              <Toggle isOn={(props.tick + index) % 2 === 0} onChange={() => undefined}>
                <Text>{index}</Text>
              </Toggle>
            </HStack>
          )
        })}
      </VStack>
    </ScrollView>
  )
}

function ChartCase(props: { size: number; tick: number }) {
  const data: ChartPointValue[] = range(props.size).map((index) => ({
    label: String(index),
    value: ((index * 17 + props.tick) % 100) + 1,
    series: index % 2 === 0 ? "A" : "B",
  }))

  return <Chart id="benchmark-chart" data={data} mark={props.tick % 2 === 0 ? "bar" : "line"} frame={{ height: 520, maxWidth: "infinity" }} />
}

function LayoutBridgeCase(props: { size: number; tick: number }) {
  return (
    <CustomLayout
      id="benchmark-layout"
      name="BenchmarkLayout"
      frame={{ height: 700, maxWidth: "infinity" }}
      sizeThatFits={layoutSizeThatFits}
      placeSubviews={layoutPlaceSubviews}
    >
      {range(props.size).map((index) => (
        <Text id={`layout-item-${index}`} key={index} font="caption" padding={2} background="tertiarySystemBackground">
          {index === props.tick % props.size ? `item ${index} tick ${props.tick}` : `item ${index}`}
        </Text>
      ))}
    </CustomLayout>
  )
}

function MixedCase(props: { size: number; tick: number }) {
  const sectionSize = Math.max(40, Math.floor(props.size / 5))

  return (
    <ScrollView id="mixed-scroll" frame={{ maxWidth: "infinity", maxHeight: "infinity" }}>
      <VStack id="mixed-stack" spacing={12}>
        <WideTextCase size={sectionSize} tick={props.tick} />
        <ControlsCase size={Math.min(sectionSize, 80)} tick={props.tick} />
        <ChartCase size={sectionSize} tick={props.tick} />
        <LayoutBridgeCase size={Math.min(sectionSize, 80)} tick={props.tick} />
      </VStack>
    </ScrollView>
  )
}

function layoutSizeThatFits(proposal: ProposedViewSize, subviews: LayoutSubview[]) {
  const replaced = proposal.replacingUnspecifiedDimensions({ width: 390, height: 700 })
  return { width: replaced.width, height: Math.max(320, Math.ceil(subviews.length / 4) * 30) }
}

function layoutPlaceSubviews(bounds: LayoutBounds, proposal: ProposedViewSize, subviews: LayoutSubview[]) {
  const columnCount = 4
  const columnWidth = Math.max(60, bounds.width / columnCount)
  const placements: LayoutPlacement[] = []

  subviews.forEach((subview, index) => {
    const measured = subview.sizeThatFits({ width: columnWidth - 8, height: 24 })
    placements.push({
      x: bounds.minX + (index % columnCount) * columnWidth,
      y: bounds.minY + Math.floor(index / columnCount) * 30,
      anchor: "topLeading",
      width: measured.width,
      height: measured.height,
    })
  })

  return placements
}

function range(count: number) {
  return Array.from({ length: Math.max(1, count) }, (_, index) => index)
}

function reportMetrics() {
  const metrics = (globalThis as RuntimeWithMetrics).__swiftjsRuntime?.benchmarkMetrics?.()
  console.log(`[SwiftJSBenchmarkJS] ${JSON.stringify(metrics ?? {})}`)
}
