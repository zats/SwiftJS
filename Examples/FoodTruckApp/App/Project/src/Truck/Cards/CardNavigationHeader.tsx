import { Button, HStack, Image, Spacer, Text } from "../../swiftjs"
import type { Panel } from "../../Support/SampleData"

export function CardNavigationHeader(props: {
  id: string
  panel: Panel
  title: string
  navigationLabel?: string
  onSelect: () => void
  systemName?: string
  assetName?: string
}) {
  return (
    <HStack id={props.id} spacing={0}>
      <Button id={`${props.id}-button`} action={props.onSelect} buttonStyle="plain">
        <HStack id={`${props.id}-label`} spacing={8}>
          {props.assetName ? (
            <Image id={`${props.id}-asset`} name={props.assetName} frame={{ width: 18, height: 18 }} />
          ) : (
            <Image id={`${props.id}-icon`} systemName={props.systemName ?? "circle"} foregroundColor="indigo" />
          )}
          <Text id={`${props.id}-title`} font="headline" fontWeight="semibold" foregroundColor="indigo">
            {props.title}
          </Text>
        </HStack>
      </Button>
      <Spacer id={`${props.id}-spacer`} />
      {props.navigationLabel ? (
        <Button id={`${props.id}-action`} action={props.onSelect} buttonStyle="plain">
          <HStack id={`${props.id}-action-label`} spacing={4}>
            <Text id={`${props.id}-action-text`} font="subheadline" fontWeight="semibold" foregroundColor="indigo">
              {props.navigationLabel}
            </Text>
            <Image id={`${props.id}-action-icon`} systemName="chevron.right" foregroundColor="indigo" />
          </HStack>
        </Button>
      ) : null}
    </HStack>
  )
}
