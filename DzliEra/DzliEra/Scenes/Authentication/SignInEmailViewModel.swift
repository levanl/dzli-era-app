//
//  SignInEmailViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 18.01.24.
//

import Foundation


final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}
