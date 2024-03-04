//
//  AuthEmailFieldComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import SwiftUI

struct AuthEmailFieldComponent: View {
    // MARK: - Properties
    @Binding var email: String
    
    // MARK: - Body
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
    }
}

struct AuthNameFieldComponent: View {
    // MARK: - Properties
    @Binding var name: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("NAME")
                .tracking(2)
                .font(.headline)
                .foregroundColor(AppColors.authFieldHeader)
            
            TextField("", text: $name)
                .background(Color.clear)
                .foregroundColor(.white)
            
            Divider().background(Color.white)
        }
    }
}
