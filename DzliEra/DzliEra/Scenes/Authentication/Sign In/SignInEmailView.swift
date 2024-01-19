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
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button  {
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
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button  {
                self.push(viewController: UIHostingController(rootView: RegisterView()), animated: true)
            } label: {
                Text("Dont Have an account register NOWW!!")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignInEmailView()
}
