//
//  HomeViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import Foundation

// MARK: - ViewModel
final class PostedWorkoutViewModel: ObservableObject {
    // MARK: - Singleton Reference
    static let shared = PostedWorkoutViewModel()
    
    // MARK: - Properties
    @Published var postableWorkouts: [PostedWorkout] = [PostedWorkout(userEmail: "example@gmail.com", time: "10", reps: "20", sets: "20", exercises: [Exercise(name: "rows", bodyPart: "fexi", equipment: .cable, gifURL: "onboarding1", id: "asiudaiu", target: "aodsoisahda"),Exercise(name: "rows", bodyPart: "fexi", equipment: .cable, gifURL: "onboarding1", id: "asiudaiu", target: "aodsoisahda")]) ]
    
    var user: DBUser?
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Fetch User
    func fetchCurrentUser() {
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
            } catch {
                print("Error loading user: \(error)")
            }
        }
    }
    
}
