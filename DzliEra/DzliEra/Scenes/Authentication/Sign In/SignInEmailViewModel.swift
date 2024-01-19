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
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                print("could not log in")
            } else {
                print("Success logged in")
            }
        }
    }
}
