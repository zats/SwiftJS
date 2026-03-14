import { Button, HStack } from "./swiftjs"
import { spacing } from "./theme"

type CounterActionsProps = {
  onIncrement: () => void
  onDecrement: () => void
  decrementDisabled?: boolean
}

export function CounterActions(props: CounterActionsProps) {
  return (
    <HStack id="counter-actions" spacing={spacing.buttonRow}>
      <Button
        id="decrement-button"
        action={props.onDecrement}
        disabled={props.decrementDisabled}
        font="largeTitle"
        frame={{ width: 80, height: 80 }}
        buttonStyle="glass"
        buttonBorderShape="circle"
        foregroundColor="white"
        glassEffect={{ tint: "red" }}
      >
        -
      </Button>

      <Button
        id="increment-button"
        action={props.onIncrement}
        font="largeTitle"
        frame={{ width: 80, height: 80 }}
        buttonStyle="glass"
        buttonBorderShape="circle"
        foregroundColor="white"
        glassEffect={{ tint: "green" }}
      >
        +
      </Button>
    </HStack>
  )
}
