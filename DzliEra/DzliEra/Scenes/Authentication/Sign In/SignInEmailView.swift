//
//  SignInEmailView.swift
//  DzliEra
//
//  Created by Levan Loladze on 18.01.24.
//

import SwiftUI
import FirebaseAuth


struct SignInEmailView: View, WithRootNavigationController {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
    var body: some View {
        
        VStack {
            
            AuthTitleComponent(firstLine: "Hello.", secondLine: "Welcome Champ")
            
            AuthEmailFieldComponent(email: $viewModel.email)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("PASSWORD")
                    .tracking(2)
                    .font(.headline)
                    .foregroundColor(AppColors.authFieldHeader)
                
                SecureField("", text: $viewModel.password)
                    .background(Color.clear)
                    .foregroundColor(.white)
                
                Divider().background(Color.white)
            }
            .padding(.bottom, 60)
            
            
            Button {
                Auth.auth().signIn(withEmail: viewModel.email, password: viewModel.password) { result, error in
                    if error != nil {
                        print(error!.localizedDescription)
                        
                        print("no LOgin")
                    } else {
                        print("Success logged in")
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(AppColors.authButtonColor)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            .padding(.bottom, 60)
            
            
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
}

#Preview {
    SignInEmailView()
}

struct AuthTitleComponent: View {
    
    let firstLine: String
    let secondLine: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(firstLine)
                .font(.custom("Helvetica-Bold", size: 35))
                .foregroundStyle(.white)
            Text(secondLine)
                .font(.custom("Helvetica-Bold", size: 35))
                .foregroundStyle(.white)
            
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding(.bottom, 120)
    }
}

struct AuthEmailFieldComponent: View {
    
    @Binding var email: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("EMAIL")
                .tracking(2)
                .font(.headline)
                .foregroundColor(AppColors.authFieldHeader)
            
            TextField("", text: $email)
                .background(Color.clear)
                .foregroundColor(.white)
            
            Divider().background(Color.white)
        }
        .padding(.bottom, 60)
    }
}
