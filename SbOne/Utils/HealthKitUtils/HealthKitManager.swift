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
    //private let activeEnergyBurnedType: HKQuantityType = HKQuantityType(.activeEnergyBurned)
    private let stepCountType: HKQuantityType = HKQuantityType(.stepCount)
    //private let exerciseTimeType: HKQuantityType = HKQuantityType(.appleExerciseTime)
    private let activitySummaryType: HKActivitySummaryType = HKObjectType.activitySummaryType()
    
    private init() {}
    
    /// Request authorization from user to read data from health store
    /// - Parameter completion: Result type that return a boolean or error
    /// important note: this function only provides an interface for user to give access and can not
    /// check if user give permisson to read or write data.
    /// important note: if user do not give access for reading values in a certian type request for the data type returns empty.
    func requestAuthorization(completion: @escaping (Result<Bool, Error>) -> ()) {
        //Check to see if HealthKit Is Available on this device
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(.failure(HealthKitError.notAvailableOnDevice))
          return
        }
        
        //let typesToRead: Set<HKObjectType> = [activeEnergyBurnedType, stepCountType, exerciseTimeType, activitySummaryType]
        let typesToRead: Set<HKObjectType> = [stepCountType, activitySummaryType]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { authorization, error in
            if let error = error {
                completion(.failure(HealthKitError.authorizationFailed(error: error)))
            }
            //this success only means that user successfully sees auth view
            completion(.success(authorization))
        }
    }
    
    func retrieveDailyStepCount(completion: @escaping (DailySteps) -> Void) {
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(
            withStart: startOfDay,
            end: now,
            options: .strictStartDate
        )
        
        var stepData = DailySteps(stepCount: 0.0, error: nil)
        
        let statisticsQuery = HKStatisticsQuery(quantityType: stepCountType,
                                      quantitySamplePredicate: predicate,
                                      options: .cumulativeSum) { _, statistics, error in
            
            if let error = error as? HKError {
                stepData.error = CodableError(errorCode: error.errorCode,
                                              errorDescription: error.localizedDescription)
                completion(stepData)
                return
            }
            guard let statistics = statistics, let sum = statistics.sumQuantity() else {
                stepData.stepCount = 0.0
                completion(stepData)
                return
            }
            stepData.stepCount = sum.doubleValue(for: HKUnit.count())
            completion(stepData)
        }
        healthStore.execute(statisticsQuery)
    }
    
    /// Returns today's activity summary till execution time
    /// - Parameter completion: to return activity summary data
    func retrieveActivitySummary(completion: @escaping(ActivitySummary) -> Void) {
        let calendar = Calendar.current
        let components: Set<Calendar.Component> = [.day, .month, .year, .era]
        var dateComponentsToday = calendar.dateComponents(components, from: Date())
        dateComponentsToday.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponentsToday)
        
        let summaryQuery = HKActivitySummaryQuery(predicate: predicate) { query, summaries, error in
            var summaryData = ActivitySummary(exerciseTime: 0,
                                              exerciseTimeGoal: 0,
                                              activeEnergyBurned: 0,
                                              activeEnergyBurnedGoal: 0,
                                              standHour: 0,
                                              standHourGoal: 0,
                                              error: nil)
            
            if let error = error as? HKError {
                summaryData.error = CodableError(errorCode: error.errorCode,
                                                 errorDescription: error.localizedDescription)
                completion(summaryData)
                return
            }
            
            guard let summaries = summaries else {
                summaryData.error = CodableError(errorCode: -1,
                                                 errorDescription: "Summarie data retrieving error.")
                completion(summaryData)
                return
            }
            
            for summary in summaries {
                let exerciseTime = summary.appleExerciseTime.doubleValue(for: HKUnit.minute())
                let exerciseTimeGoal = summary.exerciseTimeGoal?.doubleValue(for: HKUnit.minute())
                let activeEnergyBurned = summary.activeEnergyBurned.doubleValue(for: HKUnit.kilocalorie())
                let activeEnergyBurnedGoal = summary.activeEnergyBurnedGoal.doubleValue(for: HKUnit.kilocalorie())
                let standHour = summary.appleStandHours.doubleValue(for: HKUnit.count())
                let standHourGoal = summary.standHoursGoal?.doubleValue(for: HKUnit.count())
                
                summaryData.exerciseTime = exerciseTime
                summaryData.exerciseTimeGoal = exerciseTimeGoal ?? 0.0
                summaryData.activeEnergyBurned = activeEnergyBurned
                summaryData.activeEnergyBurnedGoal = activeEnergyBurnedGoal
                summaryData.standHour = standHour
                summaryData.standHourGoal = standHourGoal ?? 0.0
            }
            completion(summaryData)
        }
        
        healthStore.execute(summaryQuery)
    }
    
}
