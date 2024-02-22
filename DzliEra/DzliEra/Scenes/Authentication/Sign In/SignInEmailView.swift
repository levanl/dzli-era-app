//
//  SignInEmailView.swift
//  DzliEra
//
//  Created by Levan Loladze on 18.01.24.
//

import SwiftUI
import FirebaseAuth


struct SignInEmailView: View, WithRootNavigationController {
    // MARK: - Properties
    @StateObject private var viewModel = SignInEmailViewModel()
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            AuthTitleComponent(firstLine: "Hello.", secondLine: "Welcome Champ")
                .padding(.bottom, 100)
            
            VStack(spacing: 60) {
                AuthEmailFieldComponent(email: $viewModel.email)
                AuthPasswordFieldComponent(password: $viewModel.password)
                AuthButton(action: signInWithUser, label: Text("Sign In"))
                    .padding(.bottom, 60)
            }
            
            Button  {
                self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
            } label: {
                Text("Create Account")
            }
            
            Spacer()
        }
        .padding()
        .padding()
        .background(AppColors.authPageBackground)
        
    }
    
    func signInWithUser() {
        Task {
            do {
                try await viewModel.signIn()
                
                let tabController = TabController()
                let navigationController = UINavigationController(rootViewController: tabController)
                
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {
                        window.rootViewController = navigationController
                        window.makeKeyAndVisible()
                    }, completion: nil)
                }
            } catch {
                print("Error signing in: \(error)")
            }
        }
    }

}

#Preview {
    SignInEmailView()
}


