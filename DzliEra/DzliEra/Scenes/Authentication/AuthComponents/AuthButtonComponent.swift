//
//  AuthButtonComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import SwiftUI

struct AuthButton: View {
    // MARK: - Properties
    let action: () -> Void
    let label: Text

    // MARK: - bODY
    var body: some View {
        Button(action: action) {
            label
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(AppColors.authButtonColor)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
        }
    }
}
