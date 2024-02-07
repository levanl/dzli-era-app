//
//  ButtonExtension.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI


extension Button {
    var signUpButtonStyle: some View {
        self
            .frame(maxWidth: 200)
            .padding()
            .frame(height: 56)
            .foregroundColor(.black)
            .background(.yellow)
            .cornerRadius(40)
    }
}
