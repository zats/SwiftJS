import EventKit
import Foundation
import SwiftJSCore

@MainActor
public final class SwiftJSCalendarModule: NSObject, JSRuntimeModule {
    public let name = "calendar"

    private let store = EKEventStore()
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let dateFormatter = ISO8601DateFormatter()

    public override init() {
        super.init()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }

    public func invoke(
        method: String,
        payloadJSON: String?,
        completion: @escaping (Result<String?, Error>) -> Void
    ) {
        switch method {
        case "authorizationStatusForEvents":
            complete(completion, with: AuthorizationStatusResponse(value: EKEventStore.authorizationStatus(for: .event).jsValue))
        case "requestFullAccessToEvents":
            requestFullAccessToEvents(completion: completion)
        case "requestWriteOnlyAccessToEvents":
            requestWriteOnlyAccessToEvents(completion: completion)
        case "calendarsForEvents":
            complete(completion, with: store.calendars(for: .event).map(CalendarResponse.init(calendar:)))
        case "defaultCalendarForNewEvents":
            complete(completion, with: store.defaultCalendarForNewEvents.map(CalendarResponse.init(calendar:)))
        case "calendarWithIdentifier":
            calendarWithIdentifier(payloadJSON: payloadJSON, completion: completion)
        case "eventWithIdentifier":
            eventWithIdentifier(payloadJSON: payloadJSON, completion: completion)
        case "eventsMatching":
            eventsMatching(payloadJSON: payloadJSON, completion: completion)
        case "saveEvent":
            saveEvent(payloadJSON: payloadJSON, completion: completion)
        case "removeEvent":
            removeEvent(payloadJSON: payloadJSON, completion: completion)
        default:
            completion(.failure(CalendarModuleError.unknownMethod(method)))
        }
    }

    private func requestFullAccessToEvents(completion: @escaping (Result<String?, Error>) -> Void) {
        let completionBox = CompletionBox(completion)
        store.requestFullAccessToEvents { [weak self, completionBox] granted, error in
            Task { @MainActor [weak self] in
                guard let self else { return }
                if let error {
                    completionBox.completion(.failure(error))
                    return
                }
                self.complete(completionBox.completion, with: AccessRequestResponse(granted: granted))
            }
        }
    }

    private func requestWriteOnlyAccessToEvents(completion: @escaping (Result<String?, Error>) -> Void) {
        let completionBox = CompletionBox(completion)
        store.requestWriteOnlyAccessToEvents { [weak self, completionBox] granted, error in
            Task { @MainActor [weak self] in
                guard let self else { return }
                if let error {
                    completionBox.completion(.failure(error))
                    return
                }
                self.complete(completionBox.completion, with: AccessRequestResponse(granted: granted))
            }
        }
    }

    private func calendarWithIdentifier(payloadJSON: String?, completion: @escaping (Result<String?, Error>) -> Void) {
        do {
            let payload = try decode(CalendarIdentifierRequest.self, from: payloadJSON)
            complete(completion, with: store.calendar(withIdentifier: payload.identifier).map(CalendarResponse.init(calendar:)))
        } catch {
            completion(.failure(error))
        }
    }

    private func eventWithIdentifier(payloadJSON: String?, completion: @escaping (Result<String?, Error>) -> Void) {
        do {
            let payload = try decode(EventIdentifierRequest.self, from: payloadJSON)
            complete(
                completion,
                with: store.event(withIdentifier: payload.identifier).map { event in
                    EventResponse(event: event, dateFormatter: dateFormatter)
                }
            )
        } catch {
            completion(.failure(error))
        }
    }

    private func eventsMatching(payloadJSON: String?, completion: @escaping (Result<String?, Error>) -> Void) {
        do {
            let payload = try decode(EventsMatchingRequest.self, from: payloadJSON)
            let startDate = try parseDate(payload.startDate)
            let endDate = try parseDate(payload.endDate)
            let calendars = payload.calendarIdentifiers?.compactMap { store.calendar(withIdentifier: $0) }
            let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
            let events = store.events(matching: predicate)
                .sorted { $0.compareStartDate(with: $1) == .orderedAscending }
                .map { event in EventResponse(event: event, dateFormatter: dateFormatter) }
            complete(completion, with: events)
        } catch {
            completion(.failure(error))
        }
    }

    private func saveEvent(payloadJSON: String?, completion: @escaping (Result<String?, Error>) -> Void) {
        do {
            let payload = try decode(SaveEventRequest.self, from: payloadJSON)
            let event = try resolvedEvent(for: payload.event)
            try apply(payload.event, to: event)
            try store.save(event, span: payload.span.ekValue)

            complete(completion, with: EventResponse(event: event, dateFormatter: dateFormatter))
        } catch {
            completion(.failure(error))
        }
    }

    private func removeEvent(payloadJSON: String?, completion: @escaping (Result<String?, Error>) -> Void) {
        do {
            let payload = try decode(RemoveEventRequest.self, from: payloadJSON)
            guard let event = store.event(withIdentifier: payload.identifier) else {
                completion(.failure(CalendarModuleError.missingEvent(payload.identifier)))
                return
            }
            try store.remove(event, span: payload.span.ekValue)

            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }

    private func resolvedEvent(for payload: EventInput) throws -> EKEvent {
        if let identifier = payload.identifier {
            guard let event = store.event(withIdentifier: identifier) else {
                throw CalendarModuleError.missingEvent(identifier)
            }
            return event
        }

        return EKEvent(eventStore: store)
    }

    private func apply(_ payload: EventInput, to event: EKEvent) throws {
        if let calendarIdentifier = payload.calendarIdentifier {
            guard let calendar = store.calendar(withIdentifier: calendarIdentifier) else {
                throw CalendarModuleError.missingCalendar(calendarIdentifier)
            }
            event.calendar = calendar
        } else if payload.identifier == nil, event.calendar == nil {
            guard let calendar = store.defaultCalendarForNewEvents else {
                throw CalendarModuleError.missingDefaultCalendar
            }
            event.calendar = calendar
        }

        event.title = payload.title
        event.startDate = try parseDate(payload.startDate)
        event.endDate = try parseDate(payload.endDate)
        event.isAllDay = payload.isAllDay ?? false
        event.location = payload.location
        event.notes = payload.notes
        event.url = payload.url.flatMap(URL.init(string:))
        event.timeZone = payload.timeZoneIdentifier.flatMap(TimeZone.init(identifier:))

        if let availability = payload.availability {
            event.availability = availability.ekValue
        }
    }

    private func parseDate(_ value: String) throws -> Date {
        if let date = dateFormatter.date(from: value) {
            return date
        }

        throw CalendarModuleError.invalidDate(value)
    }

    private func decode<Value: Decodable>(_ type: Value.Type, from payloadJSON: String?) throws -> Value {
        guard let payloadJSON else {
            throw CalendarModuleError.missingPayload
        }

        return try decoder.decode(Value.self, from: Data(payloadJSON.utf8))
    }

    private func complete<Value: Encodable>(_ completion: @escaping (Result<String?, Error>) -> Void, with value: Value?) {
        do {
            if let value {
                let json = String(decoding: try encoder.encode(value), as: UTF8.self)
                completion(.success(json))
            } else {
                completion(.success(nil))
            }
        } catch {
            completion(.failure(error))
        }
    }
}

private enum CalendarModuleError: LocalizedError {
    case invalidDate(String)
    case missingCalendar(String)
    case missingDefaultCalendar
    case missingEvent(String)
    case missingPayload
    case unknownMethod(String)

    var errorDescription: String? {
        switch self {
        case let .invalidDate(value):
            return "Invalid ISO8601 date '\(value)'"
        case let .missingCalendar(identifier):
            return "Missing calendar '\(identifier)'"
        case .missingDefaultCalendar:
            return "No default calendar is available for new events."
        case let .missingEvent(identifier):
            return "Missing event '\(identifier)'"
        case .missingPayload:
            return "Calendar request payload is required."
        case let .unknownMethod(method):
            return "Unknown calendar method '\(method)'"
        }
    }
}

private final class CompletionBox: @unchecked Sendable {
    let completion: (Result<String?, Error>) -> Void

    init(_ completion: @escaping (Result<String?, Error>) -> Void) {
        self.completion = completion
    }
}

private struct AuthorizationStatusResponse: Codable {
    let value: EventAuthorizationStatus
}

private struct AccessRequestResponse: Codable {
    let granted: Bool
}

private struct CalendarIdentifierRequest: Codable {
    let identifier: String
}

private struct EventIdentifierRequest: Codable {
    let identifier: String
}

private struct EventsMatchingRequest: Codable {
    let startDate: String
    let endDate: String
    let calendarIdentifiers: [String]?
}

private struct SaveEventRequest: Codable {
    let event: EventInput
    let span: EventSpan
}

private struct RemoveEventRequest: Codable {
    let identifier: String
    let span: EventSpan
}

private struct SourceResponse: Codable {
    let sourceIdentifier: String
    let title: String
    let sourceType: SourceType
    let isDelegate: Bool

    init(source: EKSource) {
        sourceIdentifier = source.sourceIdentifier
        title = source.title
        sourceType = source.sourceType.jsValue
        isDelegate = source.isDelegate
    }
}

private struct CalendarResponse: Codable {
    let calendarIdentifier: String
    let title: String
    let type: CalendarType
    let allowsContentModifications: Bool
    let isSubscribed: Bool
    let isImmutable: Bool
    let source: SourceResponse

    init(calendar: EKCalendar) {
        calendarIdentifier = calendar.calendarIdentifier
        title = calendar.title
        type = calendar.type.jsValue
        allowsContentModifications = calendar.allowsContentModifications
        isSubscribed = calendar.isSubscribed
        isImmutable = calendar.isImmutable
        source = SourceResponse(source: calendar.source)
    }
}

private struct EventResponse: Codable {
    let eventIdentifier: String?
    let calendarItemIdentifier: String
    let calendarIdentifier: String
    let title: String
    let location: String?
    let notes: String?
    let url: String?
    let startDate: String
    let endDate: String
    let isAllDay: Bool
    let availability: EventAvailability
    let status: EventStatus
    let timeZoneIdentifier: String?
    let creationDate: String?
    let lastModifiedDate: String?

    init(event: EKEvent, dateFormatter: ISO8601DateFormatter) {
        eventIdentifier = event.eventIdentifier
        calendarItemIdentifier = event.calendarItemIdentifier
        calendarIdentifier = event.calendar.calendarIdentifier
        title = event.title
        location = event.location
        notes = event.notes
        url = event.url?.absoluteString
        startDate = dateFormatter.string(from: event.startDate)
        endDate = dateFormatter.string(from: event.endDate)
        isAllDay = event.isAllDay
        availability = event.availability.jsValue
        status = event.status.jsValue
        timeZoneIdentifier = event.timeZone?.identifier
        creationDate = event.creationDate.map(dateFormatter.string(from:))
        lastModifiedDate = event.lastModifiedDate.map(dateFormatter.string(from:))
    }
}

private struct EventInput: Codable {
    let identifier: String?
    let calendarIdentifier: String?
    let title: String
    let location: String?
    let notes: String?
    let url: String?
    let startDate: String
    let endDate: String
    let isAllDay: Bool?
    let timeZoneIdentifier: String?
    let availability: EventAvailability?
}

private enum EventAuthorizationStatus: String, Codable {
    case notDetermined
    case restricted
    case denied
    case fullAccess
    case writeOnly
}

private enum CalendarType: String, Codable {
    case local
    case calDAV
    case exchange
    case subscription
    case birthday
}

private enum SourceType: String, Codable {
    case local
    case exchange
    case calDAV
    case mobileMe
    case subscribed
    case birthdays
}

private enum EventAvailability: String, Codable {
    case notSupported
    case busy
    case free
    case tentative
    case unavailable

    var ekValue: EKEventAvailability {
        switch self {
        case .notSupported:
            return .notSupported
        case .busy:
            return .busy
        case .free:
            return .free
        case .tentative:
            return .tentative
        case .unavailable:
            return .unavailable
        }
    }
}

private enum EventStatus: String, Codable {
    case none
    case confirmed
    case tentative
    case canceled
}

private enum EventSpan: String, Codable {
    case thisEvent
    case futureEvents

    var ekValue: EKSpan {
        switch self {
        case .thisEvent:
            return .thisEvent
        case .futureEvents:
            return .futureEvents
        }
    }
}

private extension EKAuthorizationStatus {
    var jsValue: EventAuthorizationStatus {
        switch self {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .fullAccess:
            return .fullAccess
        case .writeOnly:
            return .writeOnly
        case .authorized:
            return .fullAccess
        @unknown default:
            return .denied
        }
    }
}

private extension EKCalendarType {
    var jsValue: CalendarType {
        switch self {
        case .local:
            return .local
        case .calDAV:
            return .calDAV
        case .exchange:
            return .exchange
        case .subscription:
            return .subscription
        case .birthday:
            return .birthday
        @unknown default:
            return .local
        }
    }
}

private extension EKSourceType {
    var jsValue: SourceType {
        switch self {
        case .local:
            return .local
        case .exchange:
            return .exchange
        case .calDAV:
            return .calDAV
        case .mobileMe:
            return .mobileMe
        case .subscribed:
            return .subscribed
        case .birthdays:
            return .birthdays
        @unknown default:
            return .local
        }
    }
}

private extension EKEventAvailability {
    var jsValue: EventAvailability {
        switch self {
        case .notSupported:
            return .notSupported
        case .busy:
            return .busy
        case .free:
            return .free
        case .tentative:
            return .tentative
        case .unavailable:
            return .unavailable
        @unknown default:
            return .notSupported
        }
    }
}

private extension EKEventStatus {
    var jsValue: EventStatus {
        switch self {
        case .none:
            return .none
        case .confirmed:
            return .confirmed
        case .tentative:
            return .tentative
        case .canceled:
            return .canceled
        @unknown default:
            return .none
        }
    }
}
