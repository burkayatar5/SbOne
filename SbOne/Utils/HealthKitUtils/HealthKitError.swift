//
//  HealthKitError.swift
//  SbOne
//
//  Created by Burkay Atar on 9.03.2024.
//

import Foundation


enum HealthKitError: Error {
    case notAvailableOnDevice
    case readTypeNotAvailable
    case authorizationFailed(error: Error)
    case retrievingError(error: Error)
}
