//
//  HealthKitManager.swift
//  SbOne
//
//  Created by Burkay Atar on 9.03.2024.
//

import Foundation
import HealthKit



final class HealthKitManager {
    static let shared: HealthKitManager = HealthKitManager()
    private let healthStore: HKHealthStore = HKHealthStore()
    
    //HealthStore value types app wants to read
    private let activeEnergyBurned: HKQuantityType = HKQuantityType(.activeEnergyBurned)
    private let stepCount: HKQuantityType = HKQuantityType(.stepCount)
    private let exerciseTime: HKQuantityType = HKQuantityType(.appleExerciseTime)
    private let activitySummaryType: HKActivitySummaryType = HKObjectType.activitySummaryType()
    
    private init() {}
    
    /// Request authorization from user to read data from health store
    /// - Parameter completion: Result type that return a boolean or error
    func requestAuthorization(completion: @escaping (Result<Bool, Error>) -> ()) {
        //Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(.failure(HealthKitError.notAvailableOnDevice))
          return
        }
        
        let typesToRead: Set<HKObjectType> = [activeEnergyBurned, stepCount, exerciseTime, activitySummaryType]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { authorization, error in
            
            if let error = error {
                completion(.failure(HealthKitError.authorizationFailed(error: error)))
            }
            
            completion(.success(authorization))
        }
    }
    
}
