//
//  InfoBox.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI

// MARK: - InfoBox
struct InfoBox: View {
    
    // MARK: - Properties
    var title: String
    var value: String
    var icon: String?
    
    // MARK: - Body
    var body: some View {
        VStack {
            if let icon = icon {
                Image(icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
            }
            
            Text(value)
                .font(.title)
                .foregroundColor(.black)
            
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
