//
//  CardManagerView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.03.24.
//

import SwiftUI
import SplineRuntime

struct CardManagerView: View {
    
    @FocusState private var activeTF: ActiveKeyboardField!
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var cvvCode: String = ""
    @State private var expireDate: String = ""
    
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
            
            VStack(spacing: 10) {
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: $cardNumber)
                        .font(.title3)
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .cardNumber)
                    
                    
                    Spacer(minLength: 0)
                    
                    Image("Visa")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 35)
                }
                
                HStack(spacing: 12) {
                    TextField("MM/YY", text: $expireDate)
                        .keyboardType(.numberPad)
                        .focused($activeTF, equals: .expirationDate)
                    
                    Spacer(minLength: 0)
                    
                    TextField("CVV", text: $cvvCode)
                        .frame(width: 35)
                        .focused($activeTF, equals: .ccv)
                        .keyboardType(.numberPad)
                    
                    Image(systemName: "questionmark.circle.fill")
                }
                .padding(.top, 15)
                
                Spacer(minLength: 0)

                TextField("CARD HOLDER NAME", text: $cardNumber)
                    .focused($activeTF, equals: .cardHolderName)
                
            }
            .padding(20)
            .environment(\.colorScheme, .dark)
            .tint(.white)
            
        }
        .frame(height: 200)
        .padding(.top, 35)
    }
}

#Preview {
    CardManagerView()
}


enum ActiveKeyboardField {
    case cardNumber
    case cardHolderName
    case expirationDate
    case ccv
}
