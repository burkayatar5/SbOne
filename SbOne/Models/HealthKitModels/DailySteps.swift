//
//  DailySteps.swift
//  SbOne
//
//  Created by Burkay Atar on 16.03.2024.
//

import Foundation

struct DailySteps: Codable {
    var stepCount: Double
    var error: CodableError? = nil
}
