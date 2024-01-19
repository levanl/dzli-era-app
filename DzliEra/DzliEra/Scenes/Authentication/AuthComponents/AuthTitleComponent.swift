//
//  AuthTitleComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 19.01.24.
//

import SwiftUI

struct AuthTitleComponent: View {
    // MARK: - Properties
    let firstLine: String
    let secondLine: String
    
    // MARK: - Body
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
    }
}
