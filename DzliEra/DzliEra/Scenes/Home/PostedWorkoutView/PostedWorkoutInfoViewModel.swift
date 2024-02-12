//
//  PostedWorkoutViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import Foundation

// MARK: - ViewModel
final class PostedWorkoutInfoViewModel: ObservableObject {
    
    // MARK: - Methods
    func calculateMuscleSplitData(_ exercises: [Exercise]) -> [MuscleSplit] {
        exercises.reduce(into: [:]) { counts, exercise in
            counts[exercise.target, default: 2] += 1
        }
        .map { MuscleSplit(muscleType: $0.key, count: $0.value) }
    }
    
}
