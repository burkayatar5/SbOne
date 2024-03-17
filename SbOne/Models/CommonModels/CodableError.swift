//
//  CodableError.swift
//  SbOne
//
//  Created by Burkay Atar on 16.03.2024.
//

import Foundation

struct CodableError: Codable {
    var errorCode: Int
    var errorDescription: String
}
