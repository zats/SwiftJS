import { Button, Divider, HStack, Image, Text, VStack, useState } from "./swiftjs"
import { CounterActions } from "./CounterActions"
import { spacing } from "./theme"

export function ContentView() {
  const [counter, setCounter] = useState(0)

  return (
    <VStack id="counter-root" spacing={spacing.section} padding={spacing.screenPadding}>
      <HStack id="counter-header" spacing={12} padding={8}>
        <Image
          id="counter-header-symbol"
          systemName="app.badge.fill"
          font={{ system: { size: 34, weight: "semibold" } }}
          foregroundColor="orange"
          symbolRenderingMode="multicolor"
        />

        <VStack id="counter-header-copy" spacing={spacing.compact}>
          <Text
            id="counter-title"
            font="largeTitle"
            fontWeight="bold"
            onAppear={() => {
              console.log("Counter title appeared")
            }}
          >
            Counter App
          </Text>

          <Text id="counter-subtitle" font="caption" foregroundColor="secondary">
            Native SwiftUI views driven by a JS surface
          </Text>
        </VStack>
      </HStack>

      <Text
        id="counter-value"
        font={{ system: { size: 80, weight: "bold" } }}
        padding={16}
      >
        {String(counter)}
      </Text>

      <CounterActions
        onIncrement={() => setCounter((current) => current + 1)}
        onDecrement={() => {
          if (counter > 0) {
            setCounter((current) => current - 1)
          }
        }}
        decrementDisabled={counter === 0}
      />

      <Divider id="counter-divider" />

      <HStack id="counter-native-row" spacing={12} padding={8}>
        <Image
          id="counter-native-icon"
          systemName="iphone.gen3.radiowaves.left.and.right.circle.fill"
          font={{ system: { size: 24, weight: "regular" } }}
          foregroundColor="mint"
          symbolRenderingMode="hierarchical"
        />

        <Text id="counter-native-copy" font="body">
          SF Symbols and native layout are rendered by SwiftUI.
        </Text>
      </HStack>

      <Button
        id="reset-button"
        action={() => setCounter(0)}
        disabled={counter === 0}
        font="title"
        padding={16}
        paddingTop={spacing.resetTop}
        buttonStyle="borderedProminent"
        buttonBorderShape="capsule"
      >
        Reset
      </Button>
    </VStack>
  )
}
