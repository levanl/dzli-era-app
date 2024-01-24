//
//  NewRoutineViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 23.01.24.
//

import Foundation


final class NewRoutineViewModel {
    
    // MARK: - Properties
    weak var delegate: NewRoutineDelegate?
    var exercises: [Exercise] = []

    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
}
