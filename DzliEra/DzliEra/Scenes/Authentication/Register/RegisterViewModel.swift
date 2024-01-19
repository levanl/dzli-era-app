//
//  RegisterViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import Foundation


final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func Register() {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email and password found")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error \(error)")
            }
        }
    }
}
