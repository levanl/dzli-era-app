//
//  ProfileViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import Foundation

// MARK: - ProfileViewModel
final class ProfileViewModel {
    
    // MARK: - Properties
    private var user: DBUser?
    
    var profileLabel: String? {
        return user?.email
    }
    var nameLabel: String? {
        return user?.name
    }
    var bioLabel: String? {
        return user?.bio
    }
    
    // MARK: - Methods
    func fetchUserProfile(completion: @escaping (Error?) -> Void) {
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
                completion(nil)
            } catch {
                print("Error loading user: \(error)")
                completion(error)
            }
        }
    }
    
}
