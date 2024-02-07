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
    @Published var didCompleteRegistration = false
    
    func Register(completion: @escaping () -> Void) {
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
                
                DispatchQueue.main.async {
                    self.didCompleteRegistration = true
                    completion()
                }
            } catch {
                print("Error \(error)")
                DispatchQueue.main.async {
                    self.didCompleteRegistration = false
                    completion() 
                }
            }
        }
    }
}
