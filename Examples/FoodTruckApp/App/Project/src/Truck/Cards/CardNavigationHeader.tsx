import { Button, HStack, Spacer } from "../../swiftjs"

export function CardNavigationHeader(props: {
  onSelect: () => void
  children?: unknown
}) {
  return (
    <HStack spacing={0}>
      <Button action={props.onSelect} buttonStyle="plain">
        {props.children}
      </Button>
      <Spacer />
    </HStack>
  )
}
