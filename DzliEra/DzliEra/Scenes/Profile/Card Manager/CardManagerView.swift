//
//  CardManagerView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.03.24.
//

import SwiftUI
import SplineRuntime

struct CardManagerView: View {
    
    @State private var activeTF: ActiveKeyboardField
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "xmark")
                }
                
                Text("Add Card")
                    .font(.title3)
                    .padding(.leading, 10)
                
                Spacer(minLength: 0)
                
                Button {
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                }
            }
            
            CardView()
            
            Spacer(minLength: 0)
        }
        .padding()
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [Color("CardGradient1"),
                                               Color("CardGradient2")],
                                      startPoint: .topLeading, endPoint: .bottomTrailing) )
        }
        .frame(height: 200)
        .padding(.top, 35)
    }
}

#Preview {
    CardManagerView(activeTF: <#ActiveKeyboardField#>)
}


enum ActiveKeyboardField {
    case cardNumber
    case cardHolderName
    case expirationDate
    case ccv
}
