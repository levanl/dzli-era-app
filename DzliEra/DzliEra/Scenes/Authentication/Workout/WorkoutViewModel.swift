//
//  WorkoutViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import Foundation

// MARK: - ViewModel
final class WorkoutViewModel {
    // MARK: - Properties
    var routines: [Routine] = []

    // MARK: - Methods
    func addRoutine(title: String, exercises: [Exercise]) {
        let newRoutine = Routine(title: title, exercises: exercises)
        routines.append(newRoutine)
    }
}
