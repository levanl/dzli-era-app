//
//  SaveWorkoutModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit

// MARK: - DoneWorkout Model
struct DoneWorkout {
    var title: String
    var elapsedTime: Int
    var totalReps: Int
    var totalSets: Int
    var images: [UIImage]
    var exercises: [Exercise]
}
