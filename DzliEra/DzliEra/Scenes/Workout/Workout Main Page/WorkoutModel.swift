//
//  WorkoutModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import Foundation

// MARK: - Model
struct Routine: Codable {
    var title: String
    var exercises: [Exercise]
}
