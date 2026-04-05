import CoreLocation
import Foundation
import SwiftJSCore

@MainActor
public final class SwiftJSLocationModule: NSObject, JSRuntimeModule, @preconcurrency CLLocationManagerDelegate {
    public let name = "location"

    private let manager = CLLocationManager()
    private let encoder = JSONEncoder()
    private var authorizationContinuations: [(Result<String?, Error>) -> Void] = []
    private var locationContinuations: [(Result<String?, Error>) -> Void] = []
    private var isRequestingLocation = false

    public override init() {
        super.init()
        manager.delegate = self
    }

    public func invoke(
        method: String,
        payloadJSON: String?,
        completion: @escaping (Result<String?, Error>) -> Void
    ) {
        switch method {
        case "authorizationStatus":
            do {
                completion(.success(try encodeStatus(manager.authorizationStatus)))
            } catch {
                completion(.failure(error))
            }
        case "accuracyAuthorization":
            do {
                completion(.success(try encodeAccuracyAuthorization(manager.accuracyAuthorization)))
            } catch {
                completion(.failure(error))
            }
        case "locationServicesEnabled":
            do {
                completion(.success(try encodeLocationServicesEnabled(CLLocationManager.locationServicesEnabled())))
            } catch {
                completion(.failure(error))
            }
        case "requestWhenInUseAuthorization":
            requestWhenInUseAuthorization(completion: completion)
        case "requestLocation":
            requestCurrentLocation(completion: completion)
        default:
            completion(.failure(LocationModuleError.unknownMethod(method)))
        }
    }

    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard manager.authorizationStatus != .notDetermined, !authorizationContinuations.isEmpty else {
            return
        }

        do {
            let payloadJSON = try encodeStatus(manager.authorizationStatus)
            let continuations = authorizationContinuations
            authorizationContinuations.removeAll()
            continuations.forEach { $0(.success(payloadJSON)) }
        } catch {
            let continuations = authorizationContinuations
            authorizationContinuations.removeAll()
            continuations.forEach { $0(.failure(error)) }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        isRequestingLocation = false

        guard let location = locations.last else {
            let continuations = locationContinuations
            locationContinuations.removeAll()
            continuations.forEach { $0(.failure(LocationModuleError.locationUnavailable)) }
            return
        }

        do {
            let payloadJSON = try encodeLocation(location)
            let continuations = locationContinuations
            locationContinuations.removeAll()
            continuations.forEach { $0(.success(payloadJSON)) }
        } catch {
            let continuations = locationContinuations
            locationContinuations.removeAll()
            continuations.forEach { $0(.failure(error)) }
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isRequestingLocation = false
        let continuations = locationContinuations
        locationContinuations.removeAll()
        continuations.forEach { $0(.failure(error)) }
    }

    private func requestWhenInUseAuthorization(completion: @escaping (Result<String?, Error>) -> Void) {
        if !CLLocationManager.locationServicesEnabled() {
            completion(.failure(LocationModuleError.locationServicesDisabled))
            return
        }

        if manager.authorizationStatus != .notDetermined {
            do {
                completion(.success(try encodeStatus(manager.authorizationStatus)))
            } catch {
                completion(.failure(error))
            }
            return
        }

        authorizationContinuations.append(completion)

        if authorizationContinuations.count == 1 {
            manager.requestWhenInUseAuthorization()
        }
    }

    private func requestCurrentLocation(completion: @escaping (Result<String?, Error>) -> Void) {
        if !CLLocationManager.locationServicesEnabled() {
            completion(.failure(LocationModuleError.locationServicesDisabled))
            return
        }

        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .notDetermined:
            completion(.failure(LocationModuleError.authorizationRequired))
            return
        case .restricted:
            completion(.failure(LocationModuleError.locationRestricted))
            return
        case .denied:
            completion(.failure(LocationModuleError.locationDenied))
            return
        @unknown default:
            completion(.failure(LocationModuleError.locationUnavailable))
            return
        }

        locationContinuations.append(completion)

        if !isRequestingLocation {
            isRequestingLocation = true
            manager.requestLocation()
        }
    }

    private func encodeStatus(_ status: CLAuthorizationStatus) throws -> String {
        try encode(AuthorizationStatusResponse(value: status.locationAuthorizationStatus))
    }

    private func encodeAccuracyAuthorization(_ accuracyAuthorization: CLAccuracyAuthorization) throws -> String {
        try encode(AccuracyAuthorizationResponse(value: accuracyAuthorization.locationAccuracyAuthorization))
    }

    private func encodeLocationServicesEnabled(_ isEnabled: Bool) throws -> String {
        try encode(LocationServicesEnabledResponse(value: isEnabled))
    }

    private func encodeLocation(_ location: CLLocation) throws -> String {
        try encode(
            LocationResponse(
                coordinate: .init(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                ),
                altitude: location.altitude,
                horizontalAccuracy: location.horizontalAccuracy,
                verticalAccuracy: location.verticalAccuracy,
                course: location.course,
                speed: location.speed,
                timestamp: location.timestamp
            )
        )
    }

    private func encode<Value: Encodable>(_ value: Value) throws -> String {
        String(decoding: try encoder.encode(value), as: UTF8.self)
    }
}

private enum LocationModuleError: LocalizedError {
    case authorizationRequired
    case locationDenied
    case locationRestricted
    case locationServicesDisabled
    case locationUnavailable
    case unknownMethod(String)

    var errorDescription: String? {
        switch self {
        case .authorizationRequired:
            return "Location authorization is required before requesting the current location."
        case .locationDenied:
            return "Location access is denied."
        case .locationRestricted:
            return "Location access is restricted."
        case .locationServicesDisabled:
            return "Location services are disabled."
        case .locationUnavailable:
            return "The current location is unavailable."
        case let .unknownMethod(method):
            return "Unknown location method '\(method)'"
        }
    }
}

private struct AuthorizationStatusResponse: Codable {
    let value: LocationAuthorizationStatus
}

private struct AccuracyAuthorizationResponse: Codable {
    let value: LocationAccuracyAuthorization
}

private struct LocationServicesEnabledResponse: Codable {
    let value: Bool
}

private struct CoordinateResponse: Codable {
    let latitude: Double
    let longitude: Double
}

private struct LocationResponse: Codable {
    let coordinate: CoordinateResponse
    let altitude: Double
    let horizontalAccuracy: Double
    let verticalAccuracy: Double
    let course: Double
    let speed: Double
    let timestamp: Date
}

private enum LocationAuthorizationStatus: String, Codable {
    case notDetermined
    case restricted
    case denied
    case authorizedAlways
    case authorizedWhenInUse
}

private enum LocationAccuracyAuthorization: String, Codable {
    case fullAccuracy
    case reducedAccuracy
}

private extension CLAuthorizationStatus {
    var locationAuthorizationStatus: LocationAuthorizationStatus {
        switch self {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorizedAlways:
            return .authorizedAlways
        case .authorizedWhenInUse:
            return .authorizedWhenInUse
        @unknown default:
            return .notDetermined
        }
    }
}

private extension CLAccuracyAuthorization {
    var locationAccuracyAuthorization: LocationAccuracyAuthorization {
        switch self {
        case .fullAccuracy:
            return .fullAccuracy
        case .reducedAccuracy:
            return .reducedAccuracy
        @unknown default:
            return .reducedAccuracy
        }
    }
}
