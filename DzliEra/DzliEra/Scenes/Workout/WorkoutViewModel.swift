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
    
    var fetchingStatus: FetchingStatus = .idle
    
    var user: DBUser?
    
    var onDataUpdate: (() -> Void)?
    
    var routines: [Routine] = []
    
    // MARK: - Methods
    func addRoutine(title: String, exercises: [Exercise]) {
        let newRoutine = Routine(title: title, exercises: exercises)
        routines.append(newRoutine)
    }
    
    func fetchRoutines() {
        self.fetchingStatus = .fetching
        
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
                let routines = try await UserManager.shared.getRoutines(userId: user?.userId ?? "none")
                self.routines = routines
                
                if routines.isEmpty {
                                // Set status to idle
                                self.fetchingStatus = .idle
                            } else {
                                // Set status to success
                                self.fetchingStatus = .success
                            }
                DispatchQueue.main.async {
                    self.onDataUpdate?()
                }
                
            } catch {
                print("Error loading user: \(error)")
                
                self.fetchingStatus = .failure
                
            }
        }
    }
    
    
}


enum FetchingStatus {
    case idle
    case fetching
    case success
    case failure
}
