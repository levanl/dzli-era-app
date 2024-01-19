//
//  RegisterView.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import SwiftUI

struct RegisterView: View, WithRootNavigationController {
    
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        TextField("Email...", text: $viewModel.email)
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
        
        SecureField("Password...", text: $viewModel.password)
            .padding()
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)
        
        Button {
            viewModel.Register()
        } label: {
            Text("Register")
        }
    }
}

#Preview {
    RegisterView()
}
