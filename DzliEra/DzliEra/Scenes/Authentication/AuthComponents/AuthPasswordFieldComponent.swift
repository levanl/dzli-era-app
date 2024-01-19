//
//  AuthPasswordFieldComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import SwiftUI

struct AuthPasswordFieldComponent: View {
    // MARK: - Properties
    @Binding var password: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("PASSWORD")
                .tracking(2)
                .font(.headline)
                .foregroundColor(AppColors.authFieldHeader)
            
            SecureField("", text: $password)
                .background(Color.clear)
                .foregroundColor(.white)
            
            Divider().background(Color.white)
        }
    }
}
