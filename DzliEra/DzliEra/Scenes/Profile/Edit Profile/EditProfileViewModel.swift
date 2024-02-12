//
//  EditProfileViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import UIKit
import SwiftUI
import PhotosUI

// MARK: - EditProfileViewModel
final class EditProfileViewModel: ObservableObject {
    // MARK: - Properties
    var user: DBUser?
    @Published var name: String = ""
    @Published var bio: String = ""
    @Published var sex: String = ""
    @Published var selectedSexIndex = 0
    @Published var sexes = ["Male", "Female", "Other"]
    
    // MARK: - Methods
    func fetchCurrentUser() {
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
    
    func saveProfileImage(item: PhotosPickerItem) {
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name) = try await StorageManager.shared.saveImage(data: data, userId: user?.userId ?? "nil")
            print("SUCCESS")
            print(path)
            print(name)
            try await UserManager.shared.updateUserProfileImage(userId: user?.userId ?? "ravime", path: name)
        }
        
    }
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
