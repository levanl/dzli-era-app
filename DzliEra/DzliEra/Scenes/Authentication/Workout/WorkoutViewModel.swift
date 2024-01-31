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
    
    var user: DBUser?

       var onDataUpdate: (() -> Void)?
    
    var routines: [Routine] = []

    // MARK: - Methods
    func addRoutine(title: String, exercises: [Exercise]) {
        let newRoutine = Routine(title: title, exercises: exercises)
        routines.append(newRoutine)
    }
    
    func fetchRoutines() {
           Task {
               do {
                   let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                   self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                   print("User loaded: \(self.user?.email ?? "Unknown email")")
                   let routines = try await UserManager.shared.getRoutines(userId: user?.userId ?? "none")
                   self.routines = routines

                   DispatchQueue.main.async {
                                       self.onDataUpdate?()
                                   }
               } catch {
                   print("Error loading user: \(error)")
               }
           }
       }
}
