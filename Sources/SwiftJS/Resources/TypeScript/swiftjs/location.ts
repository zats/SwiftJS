/**
 * Core Location bridge for permission checks and one-shot location requests.
 *
 * const manager = new CLLocationManager()
 * const status = await manager.requestWhenInUseAuthorization()
 * if (status === "authorizedWhenInUse") {
 *   const location = await manager.requestLocation()
 * }
 */
import { invokeModule } from "./index"

/** Mirrors `CLAuthorizationStatus`. */
export type CLAuthorizationStatus =
  | "notDetermined"
  | "restricted"
  | "denied"
  | "authorizedAlways"
  | "authorizedWhenInUse"

/** Mirrors `CLAccuracyAuthorization`. */
export type CLAccuracyAuthorization = "fullAccuracy" | "reducedAccuracy"

/** Mirrors `CLLocationCoordinate2D`. */
export type CLLocationCoordinate2D = {
  latitude: number
  longitude: number
}

/** Serializable subset of `CLLocation`. */
export type CLLocation = {
  coordinate: CLLocationCoordinate2D
  altitude: number
  horizontalAccuracy: number
  verticalAccuracy: number
  course: number
  speed: number
  timestamp: string
}

type ValueResponse<Value> = {
  value: Value
}

/** SwiftJS wrapper around the current `CLLocationManager` bridge. */
export class CLLocationManager {
  /** Reads the current location authorization status. */
  get authorizationStatus() {
    return invokeModule<ValueResponse<CLAuthorizationStatus>>("location", "authorizationStatus").then(
      ({ value }) => value
    )
  }

  /** Reads the current accuracy authorization. */
  get accuracyAuthorization() {
    return invokeModule<ValueResponse<CLAccuracyAuthorization>>("location", "accuracyAuthorization").then(
      ({ value }) => value
    )
  }

  /** Requests when-in-use authorization and resolves to the new status. */
  requestWhenInUseAuthorization() {
    return invokeModule<ValueResponse<CLAuthorizationStatus>>("location", "requestWhenInUseAuthorization").then(
      ({ value }) => value
    )
  }

  /**
   * Requests one location fix.
   *
   * const location = await manager.requestLocation()
   */
  requestLocation() {
    return invokeModule<CLLocation>("location", "requestLocation")
  }

  /** Reads whether device location services are enabled. */
  static locationServicesEnabled() {
    return invokeModule<ValueResponse<boolean>>("location", "locationServicesEnabled").then(({ value }) => value)
  }
}
