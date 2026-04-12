import {
  Button,
  ControlGroup,
  DisclosureGroup,
  FlowLayout,
  HStack,
  Image,
  Label,
  Menu,
  Picker,
  Toggle,
  Text,
  VStack,
  useAppStorage,
  useState,
  type PickerValue,
} from "../../swiftjs"
import { Card, DemoSection, ScreenShell } from "../components/common"
import { buttonShapes, buttonStyles, space } from "../shared"
import { controlsToolbar } from "../toolbars"

export function ControlsTab() {
  const [newsletter, setNewsletter] = useAppStorage<boolean>("catalog.newsletter", true)
  const [stringPicker, setStringPicker] = useState<PickerValue>("body")
  const [numberPicker, setNumberPicker] = useState<PickerValue>(2)
  const [expanded, setExpanded] = useState(true)
  const [menuResult, setMenuResult] = useState("None")

  return (
    <ScreenShell title="Controls" toolbar={controlsToolbar} displayMode="large">
      <DemoSection title="Buttons" detail="All button styles and border-shape options.">
        <Card title="Button Styles">
          <FlowLayout spacing={space.sm} lineSpacing={space.sm}>
            {buttonStyles.map((style) => (
              <Button
                key={style}
                action={() => setMenuResult(style)}
                buttonStyle={style}
                buttonBorderShape="capsule"
                glassEffect={style.startsWith("glass") ? { variant: style === "glassProminent" ? "clear" : "regular", tint: "blue" } : undefined}
              >
                {style}
              </Button>
            ))}
          </FlowLayout>
        </Card>

        <Card title="Button Border Shapes">
          <FlowLayout spacing={space.md} lineSpacing={space.md}>
            {buttonShapes.map((shape) => (
              <VStack key={shape} spacing={space.xs} alignment="leading">
                <Button
                  action={() => setMenuResult(shape)}
                  buttonStyle="bordered"
                  buttonBorderShape={shape}
                  frame={{ minWidth: shape === "roundedRectangle" ? 128 : 92, height: 52 }}
                >
                  {shape === "automatic" ? "Auto" : shape === "roundedRectangle" ? "Rounded" : shape === "capsule" ? "Capsule" : "Circle"}
                </Button>
                <Text font="caption" foregroundColor="secondary">
                  {shape}
                </Text>
              </VStack>
            ))}
          </FlowLayout>
        </Card>
      </DemoSection>

      <DemoSection title="Groups And Menus" detail="ControlGroup, Menu, and DisclosureGroup.">
        <Card title="ControlGroup">
          <ControlGroup>
            <Button action={() => setMenuResult("rewind")} buttonStyle="bordered">
              <Image systemName="backward.fill" />
            </Button>
            <Button action={() => setMenuResult("play")} buttonStyle="borderedProminent">
              <Image systemName="play.fill" />
            </Button>
            <Button action={() => setMenuResult("forward")} buttonStyle="bordered">
              <Image systemName="forward.fill" />
            </Button>
          </ControlGroup>
        </Card>

        <Card title="Menu" detail={`Last action: ${menuResult}`}>
          <Menu
            content={
              <VStack alignment="leading" spacing={space.xs}>
                <Button action={() => setMenuResult("favorite")} buttonStyle="plain">
                  Favorite
                </Button>
                <Button action={() => setMenuResult("pin")} buttonStyle="plain">
                  Pin
                </Button>
                <Button action={() => setMenuResult("archive")} buttonStyle="plain">
                  Archive
                </Button>
              </VStack>
            }
          >
            <Label title="Show Menu" systemName="ellipsis.circle" />
          </Menu>
        </Card>

        <Card title="DisclosureGroup">
          <DisclosureGroup
            isExpanded={expanded}
            onExpandedChange={setExpanded}
            content={
              <VStack alignment="leading" spacing={space.xs}>
                <Text>Header, body, and footer settings stay collapsed until needed.</Text>
                <Toggle isOn={newsletter} onChange={setNewsletter} tint="mint">
                  Receive updates
                </Toggle>
              </VStack>
            }
          >
            <Label title="Advanced Settings" systemName="slider.horizontal.3" />
          </DisclosureGroup>
        </Card>
      </DemoSection>

      <DemoSection title="Input" detail="Picker, Toggle, tint, disabled, and app storage.">
        <Card title="Picker">
          <VStack spacing={space.sm} alignment="leading">
            <Picker selection={stringPicker} onChange={setStringPicker} options={["largeTitle", "headline", "body", "caption"]} tint="blue">
              Text Font
            </Picker>
            <Picker
              selection={numberPicker}
              onChange={setNumberPicker}
              options={[
                { title: "One", value: 1 },
                { title: "Two", value: 2 },
                { title: "Three", value: 3 },
              ]}
              tint="orange"
            >
              Numeric Picker
            </Picker>
          </VStack>
        </Card>

        <Card title="Toggle" detail="Persisted with useAppStorage.">
          <VStack spacing={space.sm} alignment="leading">
            <Toggle isOn={newsletter} onChange={setNewsletter} tint="green">
              Email notifications
            </Toggle>
            <Toggle isOn={false} onChange={() => undefined} disabled tint="gray">
              Disabled toggle
            </Toggle>
          </VStack>
        </Card>

        <Card title="Disabled Controls">
          <HStack spacing={space.sm}>
            <Button action={() => undefined} buttonStyle="glassProminent" disabled>
              Disabled Primary
            </Button>
            <Menu
              disabled
              content={
                <VStack>
                  <Button action={() => undefined} buttonStyle="plain">
                    Hidden
                  </Button>
                </VStack>
              }
            >
              Disabled Menu
            </Menu>
          </HStack>
        </Card>
      </DemoSection>
    </ScreenShell>
  )
}
