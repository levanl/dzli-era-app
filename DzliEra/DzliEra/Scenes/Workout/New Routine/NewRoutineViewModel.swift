//
//  NewRoutineViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 23.01.24.
//

import Foundation

// MARK: - View Model
final class NewRoutineViewModel {
    
    var user: DBUser?
    
    // MARK: - Properties
    weak var delegate: NewRoutineDelegate?
    var exercises: [Exercise] = []
    
    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    // MARK: - Methods
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
    
    func uploadRoutines(userId: String, routines: [Routine]) async throws {
        try await UserManager.shared.uploadRoutines(userId: userId, routines: routines)
        print("Routines uploaded to Firestore successfully")
    }
    
    func uploadRoutinesToCollection(routines: [Routine]) async throws {
        try await UserManager.shared.uploadRoutinesToCollection(routines: routines)
        print("Routines uploaded to collection successfully")
    }
}
