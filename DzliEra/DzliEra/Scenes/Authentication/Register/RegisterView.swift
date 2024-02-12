//
//  RegisterView.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import SwiftUI

struct RegisterView: View, WithRootNavigationController {
    // MARK: - Properties
    @StateObject private var viewModel = RegisterViewModel()
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            AuthTitleComponent(firstLine: "Hello.", secondLine: "Register Champ")
                .padding(.bottom, 100)
            
            VStack(spacing: 60) {
                AuthEmailFieldComponent(email: $viewModel.email)
                AuthPasswordFieldComponent(password: $viewModel.password)
                AuthButton(action: registerToSignIn, label: Text("Register"))
            }
            Spacer()
        }
        .padding()
        .padding()
        .background(AppColors.authPageBackground)
    }
    
    private func registerToSignIn() {
        viewModel.Register {
            if viewModel.didCompleteRegistration {
                self.pop(animated: true)
            }
        }
    }
    
}

#Preview {
    RegisterView()
}
