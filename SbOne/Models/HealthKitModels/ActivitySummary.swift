//
//  ActivitySummary.swift
//  SbOne
//
//  Created by Burkay Atar on 16.03.2024.
//

import Foundation

struct ActivitySummary: Codable {
    var exerciseTime: Double
    var exerciseTimeGoal: Double
    var activeEnergyBurned: Double
    var activeEnergyBurnedGoal: Double
    var standHour: Double
    var standHourGoal: Double
    var error: CodableError? = nil
}


