/**
 * EventKit bridge for reading calendars and creating events.
 *
 * const store = new EKEventStore()
 * const granted = await store.requestFullAccessToEvents()
 * if (granted) {
 *   const events = await store.events({
 *     startDate: new Date(),
 *     endDate: new Date(Date.now() + 60 * 60 * 1000),
 *   })
 * }
 */
import { invokeModule } from "./index"

/** Mirrors `EKAuthorizationStatus` for event access. */
export type EKAuthorizationStatus = "notDetermined" | "restricted" | "denied" | "fullAccess" | "writeOnly"

/** Mirrors `EKSpan`. */
export type EKSpan = "thisEvent" | "futureEvents"

/** Mirrors `EKCalendarType`. */
export type EKCalendarType = "local" | "calDAV" | "exchange" | "subscription" | "birthday"

/** Mirrors `EKSourceType`. */
export type EKSourceType = "local" | "exchange" | "calDAV" | "mobileMe" | "subscribed" | "birthdays"

/** Mirrors `EKEventAvailability`. */
export type EKEventAvailability = "notSupported" | "busy" | "free" | "tentative" | "unavailable"

/** Mirrors `EKEventStatus`. */
export type EKEventStatus = "none" | "confirmed" | "tentative" | "canceled"

/** Serializable subset of `EKSource`. */
export type EKSource = {
  sourceIdentifier: string
  title: string
  sourceType: EKSourceType
  isDelegate: boolean
}

/** Serializable subset of `EKCalendar`. */
export type EKCalendar = {
  calendarIdentifier: string
  title: string
  type: EKCalendarType
  allowsContentModifications: boolean
  isSubscribed: boolean
  isImmutable: boolean
  source: EKSource
}

/** Serializable subset of `EKEvent`. */
export type EKEvent = {
  eventIdentifier?: string
  calendarItemIdentifier: string
  calendarIdentifier: string
  title: string
  location?: string
  notes?: string
  url?: string
  startDate: string
  endDate: string
  isAllDay: boolean
  availability: EKEventAvailability
  status: EKEventStatus
  timeZoneIdentifier?: string
  creationDate?: string
  lastModifiedDate?: string
}

/** Input payload accepted by `saveEvent`. */
export type EKEventInput = {
  identifier?: string
  calendarIdentifier?: string
  title: string
  location?: string
  notes?: string
  url?: string
  startDate: string | Date
  endDate: string | Date
  isAllDay?: boolean
  timeZoneIdentifier?: string
  availability?: EKEventAvailability
}

/** Date range predicate used by `events(matching:)`. */
export type EKEventPredicate = {
  startDate: string | Date
  endDate: string | Date
  calendarIdentifiers?: string[]
}

type AuthorizationStatusResponse = {
  value: EKAuthorizationStatus
}

type AccessRequestResponse = {
  granted: boolean
}

function iso8601(value: string | Date) {
  return value instanceof Date ? value.toISOString() : value
}

/** SwiftJS wrapper around the current `EKEventStore` bridge. */
export class EKEventStore {
  /** Reads the current authorization status for event access. */
  static authorizationStatusForEvents() {
    return invokeModule<AuthorizationStatusResponse>("calendar", "authorizationStatusForEvents").then(
      ({ value }) => value
    )
  }

  /** Requests full calendar read/write access. */
  requestFullAccessToEvents() {
    return invokeModule<AccessRequestResponse>("calendar", "requestFullAccessToEvents").then(
      ({ granted }) => granted
    )
  }

  /** Requests write-only calendar access. */
  requestWriteOnlyAccessToEvents() {
    return invokeModule<AccessRequestResponse>("calendar", "requestWriteOnlyAccessToEvents").then(
      ({ granted }) => granted
    )
  }

  /** Returns all event calendars. */
  calendarsForEvents() {
    return invokeModule<EKCalendar[]>("calendar", "calendarsForEvents")
  }

  /** Returns the default calendar for new events. */
  get defaultCalendarForNewEvents() {
    return invokeModule<EKCalendar | null>("calendar", "defaultCalendarForNewEvents")
  }

  /** Looks up a calendar by identifier. */
  calendar(identifier: string) {
    return invokeModule<EKCalendar | null>("calendar", "calendarWithIdentifier", { identifier })
  }

  /** Looks up an event by identifier. */
  event(identifier: string) {
    return invokeModule<EKEvent | null>("calendar", "eventWithIdentifier", { identifier })
  }

  /**
   * Fetches events matching a date range and optional calendar list.
   *
   * await store.events({ startDate: new Date(), endDate: tomorrow })
   */
  events(matching: EKEventPredicate) {
    return invokeModule<EKEvent[]>("calendar", "eventsMatching", {
      startDate: iso8601(matching.startDate),
      endDate: iso8601(matching.endDate),
      calendarIdentifiers: matching.calendarIdentifiers,
    })
  }

  /**
   * Creates or updates an event.
   *
   * await store.saveEvent({
   *   title: "Review",
   *   startDate: new Date(),
   *   endDate: new Date(Date.now() + 30 * 60 * 1000),
   * })
   */
  saveEvent(event: EKEventInput, options?: { span?: EKSpan }) {
    return invokeModule<EKEvent>("calendar", "saveEvent", {
      event: {
        ...event,
        startDate: iso8601(event.startDate),
        endDate: iso8601(event.endDate),
      },
      span: options?.span ?? "thisEvent",
    })
  }

  /** Removes an event by identifier. */
  removeEvent(identifier: string, options?: { span?: EKSpan }) {
    return invokeModule<void>("calendar", "removeEvent", {
      identifier,
      span: options?.span ?? "thisEvent",
    })
  }
}
