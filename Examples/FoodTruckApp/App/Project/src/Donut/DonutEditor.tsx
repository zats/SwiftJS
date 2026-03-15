import { ScrollView, Text, VStack, useState } from "../swiftjs"
import { doughOptions, glazeOptions, toppingOptions } from "../Support/SampleData"
import { DonutPreview, EditorSection } from "../Support/DonutComponents"

export function DonutEditor() {
  const [doughIndex, setDoughIndex] = useState(0)
  const [glazeIndex, setGlazeIndex] = useState(0)
  const [toppingIndex, setToppingIndex] = useState(0)

  const dough = doughOptions[doughIndex]
  const glaze = glazeOptions[glazeIndex]
  const topping = toppingOptions[toppingIndex]

  return (
    <ScrollView navigationTitle="Donut Editor" background="systemGroupedBackground">
      <VStack alignment="leading" spacing={16} padding={16}>
        <VStack alignment="center" spacing={12} padding={10} background="white" cornerRadius={20}>
          <DonutPreview recipe={{ id: "editor", name: "Custom", dough, glaze, topping, sales: "" }} size="full" />
          <Text font="title2" fontWeight="bold">
            {dough.name} / {glaze.name} / {topping.name}
          </Text>
          <Text font="subheadline" foregroundColor="secondary">
            This mirrors the original donut editor’s layered composition using reusable `VStack`, `Image`, and `Button` bindings.
          </Text>
        </VStack>

        <EditorSection title="Dough" options={doughOptions} selectedIndex={doughIndex} onSelect={setDoughIndex} />
        <EditorSection title="Glaze" options={glazeOptions} selectedIndex={glazeIndex} onSelect={setGlazeIndex} />
        <EditorSection title="Topping" options={toppingOptions} selectedIndex={toppingIndex} onSelect={setToppingIndex} />
      </VStack>
    </ScrollView>
  )
}
