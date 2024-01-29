//
//  SignInEmailViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 18.01.24.
//

import Foundation
import FirebaseAuth

final class SignInEmailViewModel: ObservableObject {
    // MARK: - Properties
    @Published var email = ""
    @Published var password = ""
    
    // MARK: - Sign In Func
    func signIn() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        let user = DBUser(userId: authDataResult.uid, email: authDataResult.email, photoUrl: authDataResult.photoUrl, dateCreated: Date())
        try await UserManager.shared.createNewUser(user: user)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}
