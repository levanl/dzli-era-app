//
//  WorkoutViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import Foundation

class WorkoutViewModel {
    var routines: [Routine] = []

    func addRoutine(title: String, exercises: [Exercise]) {
        let newRoutine = Routine(title: title, exercises: exercises)
        routines.append(newRoutine)
    }
}
