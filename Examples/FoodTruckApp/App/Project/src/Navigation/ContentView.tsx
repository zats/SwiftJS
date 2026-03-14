import { NavigationSplitView, useState } from "../swiftjs"
import { DetailColumn } from "./DetailColumn"
import { Sidebar } from "./Sidebar"
import type { Panel } from "../Support/SampleData"

export function ContentView() {
  const [selection, setSelection] = useState<Panel>("truck")

  return (
    <NavigationSplitView
      id="food-truck-root"
      sidebar={<Sidebar selection={selection} onSelect={setSelection} />}
      detail={<DetailColumn selection={selection} onSelect={setSelection} />}
    />
  )
}
