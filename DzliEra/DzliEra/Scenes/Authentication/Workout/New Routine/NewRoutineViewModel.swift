//
//  NewRoutineViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 23.01.24.
//

import Foundation


final class NewRoutineViewModel {
    
    var user: DBUser?
    
    // MARK: - Properties
    weak var delegate: NewRoutineDelegate?
    var exercises: [Exercise] = []
    
    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    func loadUser() {
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
            } catch {
                print("Error loading user: \(error)")
            }
        }
    }
}
