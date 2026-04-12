import { Button, Image, Menu, Text, type ToolbarValue } from "../swiftjs"

export const layoutToolbar: ToolbarValue = [
  { placement: "topBarLeading", content: <Image systemName="square.grid.2x2" /> },
  { placement: "principal", content: <Text font="headline">Layout</Text> },
  { placement: "topBarTrailing", content: <Button action={() => undefined} buttonStyle="plain"><Image systemName="arrow.clockwise" /></Button> },
]

export const controlsToolbar: ToolbarValue = [
  { placement: "topBarLeading", content: <Image systemName="switch.2" /> },
  { placement: "principal", content: <Text font="headline">Controls</Text> },
  { placement: "topBarTrailing", content: <Menu content={<Button action={() => undefined} buttonStyle="plain">Inspect</Button>}><Image systemName="ellipsis.circle" /></Menu> },
]

export const listsToolbar: ToolbarValue = [
  { placement: "topBarLeading", content: <Image systemName="list.bullet.rectangle" /> },
  { placement: "principal", content: <Text font="headline">Lists</Text> },
  { placement: "topBarTrailing", content: <Button action={() => undefined} buttonStyle="plain"><Image systemName="line.3.horizontal.decrease.circle" /></Button> },
]

export const presentationToolbar: ToolbarValue = [
  { placement: "principal", content: <Text font="headline">Presentation</Text> },
  { placement: "topBarTrailing", content: <Menu content={<Button action={() => undefined} buttonStyle="plain">Refresh</Button>}><Image systemName="ellipsis.circle" /></Menu> },
]

export const visualsToolbar: ToolbarValue = [
  { placement: "topBarLeading", content: <Image systemName="sparkles" /> },
  { placement: "principal", content: <Text font="headline">Visuals</Text> },
  { placement: "topBarTrailing", content: <Button action={() => undefined} buttonStyle="plain"><Image systemName="eyedropper" /></Button> },
]
