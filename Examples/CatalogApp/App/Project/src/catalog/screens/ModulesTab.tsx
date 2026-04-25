import { Button, HStack, Text, VStack, useState } from "swiftjs"
import { EKEventStore } from "swiftjs/calendar"
import { CLLocationManager } from "swiftjs/location"
import { Card, DemoSection, ScreenShell } from "../components/common"
import { space } from "../shared"

function formatError(error: unknown) {
  if (error instanceof Error) {
    return error.message
  }

  return String(error)
}

export function ModulesTab() {
  const [locationResult, setLocationResult] = useState("Not run yet.")
  const [calendarResult, setCalendarResult] = useState("Not run yet.")

  const run = (setter: (value: string) => void, task: () => Promise<string>) => () => {
    setter("Working...")
    void task()
      .then((value) => setter(value))
      .catch((error) => setter(formatError(error)))
  }

  return (
    <ScreenShell title="Modules" displayMode="large">
      <DemoSection title="Location" detail="Exercising the optional native location bridge.">
        <Card title="CLLocationManager" detail={locationResult}>
          <VStack alignment="leading" spacing={space.sm}>
            <HStack spacing={space.sm}>
              <Button action={run(setLocationResult, async () => `locationServicesEnabled=${await CLLocationManager.locationServicesEnabled()}`)} buttonStyle="bordered">
                Services Enabled
              </Button>
              <Button
                action={run(setLocationResult, async () => {
                  const manager = new CLLocationManager()
                  return `authorizationStatus=${await manager.authorizationStatus}`
                })}
                buttonStyle="bordered"
              >
                Authorization
              </Button>
            </HStack>
            <HStack spacing={space.sm}>
              <Button
                action={run(setLocationResult, async () => {
                  const manager = new CLLocationManager()
                  return `requestWhenInUseAuthorization=${await manager.requestWhenInUseAuthorization()}`
                })}
                buttonStyle="borderedProminent"
              >
                Request Access
              </Button>
              <Button
                action={run(setLocationResult, async () => {
                  const manager = new CLLocationManager()
                  const location = await manager.requestLocation()
                  return `location=${location.coordinate.latitude.toFixed(4)}, ${location.coordinate.longitude.toFixed(4)}`
                })}
                buttonStyle="bordered"
              >
                Request Location
              </Button>
            </HStack>
          </VStack>
        </Card>
      </DemoSection>

      <DemoSection title="Calendar" detail="Exercising the optional native calendar bridge.">
        <Card title="EKEventStore" detail={calendarResult}>
          <VStack alignment="leading" spacing={space.sm}>
            <HStack spacing={space.sm}>
              <Button
                action={run(setCalendarResult, async () => `authorizationStatus=${await EKEventStore.authorizationStatusForEvents()}`)}
                buttonStyle="bordered"
              >
                Authorization
              </Button>
              <Button
                action={run(setCalendarResult, async () => {
                  const store = new EKEventStore()
                  const calendars = await store.calendarsForEvents()
                  return `calendars=${calendars.length}${calendars[0] ? `, first=${calendars[0].title}` : ""}`
                })}
                buttonStyle="bordered"
              >
                List Calendars
              </Button>
            </HStack>
            <HStack spacing={space.sm}>
              <Button
                action={run(setCalendarResult, async () => {
                  const store = new EKEventStore()
                  return `requestFullAccessToEvents=${await store.requestFullAccessToEvents()}`
                })}
                buttonStyle="borderedProminent"
              >
                Request Full Access
              </Button>
              <Button
                action={run(setCalendarResult, async () => {
                  const store = new EKEventStore()
                  const calendar = await store.defaultCalendarForNewEvents
                  return calendar ? `defaultCalendar=${calendar.title}` : "defaultCalendar=nil"
                })}
                buttonStyle="bordered"
              >
                Default Calendar
              </Button>
            </HStack>
          </VStack>
        </Card>
      </DemoSection>

      <DemoSection title="Integration" detail="This screen proves the sample app resolves and calls optional module SDKs through the staged swiftjs package.">
        <Card title="Wiring">
          <Text>The native modules are linked in Xcode, passed into JSSurfaceRuntime, and imported from `swiftjs/calendar` and `swiftjs/location`.</Text>
        </Card>
      </DemoSection>
    </ScreenShell>
  )
}
