//
//  RegisterViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import Foundation


final class RegisterViewModel: ObservableObject {
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    
    func Register() {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email and password found")
            return
        }
        
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
                let user = DBUser(auth: authDataResult)
                try await UserManager.shared.createNewUser(user: user)
                print("Success Registerd")
                print(authDataResult)
            } catch {
                print("Error \(error)")
            }
        }
    }
}
