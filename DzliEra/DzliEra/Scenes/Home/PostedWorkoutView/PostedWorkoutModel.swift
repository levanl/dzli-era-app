//
//  PostedWorkoutModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import Foundation

// MARK: - Model
struct MuscleSplit: Identifiable {
    let id = UUID()
    let muscleType: String
    let count: Int
}
