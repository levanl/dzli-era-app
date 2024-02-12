//
//  SignInEmailViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 18.01.24.
//

import Foundation
import FirebaseAuth
import UIKit

final class SignInEmailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    
    // MARK: - Sign In Func
    func signIn() async throws {
        _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
}
