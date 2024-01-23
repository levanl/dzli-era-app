//
//  NewRoutineViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 23.01.24.
//

import Foundation


class NewRoutineViewModel {
    
    weak var delegate: NewRoutineDelegate?
    
    var exercises: [Exercise] = []

    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
}
