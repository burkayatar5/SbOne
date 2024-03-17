//
//  Workouts.swift
//  SbOne
//
//  Created by Burkay Atar on 23.02.2024.
//

import Foundation

struct WorkoutLeg: Codable {
    var leg: [String : WorkoutLegInfo?]
    
    private enum CodingKeys: String, CodingKey {
        case leg = "Leg"
    }
}

struct WorkoutLegInfo: Codable {
    var difficulty: Int
    var equipment: Bool
    var text: String
    
    private enum CodingKeys: String, CodingKey {
        case difficulty = "Difficulty"
        case equipment = "Equipment"
        case text = "Text"
    }
}
