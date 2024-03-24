//
//  CardManagerView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.03.24.
//

import SwiftUI
import SplineRuntime
import Combine

struct CardAddView: View {
    
    @StateObject private var viewModel = CardAddViewModel()
    @FocusState private var activeTF: ActiveKeyboardField!
    @Environment(\.dismiss) var dismiss
    @Binding var cards: [CreditCard]
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        dismiss()
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
                VStack {
                    MaterialDesignTextField($viewModel.cardNumber, placeholder: "Card Number", editing: $viewModel.editingTextField1)
                        .padding()
                        .keyboardType(.numberPad)
                        .onTapGesture { viewModel.editingTextField1 = true
                            viewModel.editingTextField2 = false
                            viewModel.editingTextField3 = false
                            viewModel.editingTextField4 = false
                        }
                    
                    MaterialDesignTextField($viewModel.cardHolderName, placeholder: "Name On Card", editing: $viewModel.editingTextField2)
                        .padding()
                        .onTapGesture { viewModel.editingTextField2 = true
                            viewModel.editingTextField1 = false
                            viewModel.editingTextField3 = false
                            viewModel.editingTextField4 = false
                        }
                    HStack(spacing: 0){
                        MaterialDesignTextField($viewModel.expireDate, placeholder: "Expiry Date", editing: $viewModel.editingTextField3)
                            .padding()
                            .keyboardType(.numberPad)
                            .onTapGesture { viewModel.editingTextField3 = true
                                viewModel.editingTextField1 = false
                                viewModel.editingTextField2 = false
                                viewModel.editingTextField4 = false
                            }
                        
                        MaterialDesignTextField($viewModel.cvvCode, placeholder: "Security Code", editing: $viewModel.editingTextField4)
                            .padding()
                            .keyboardType(.numberPad)
                            .onTapGesture { viewModel.editingTextField4 = true
                                viewModel.editingTextField1 = false
                                viewModel.editingTextField3 = false
                                viewModel.editingTextField2 = false
                            }
                    }
                    
                }
                .padding(0)
                .onTapGesture {
                    viewModel.editingTextField1 = false
                    viewModel.editingTextField2 = false
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    viewModel.addCard(cards: &cards) {
                        dismiss()
                    }
                }) {
                    Text("Save Card")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(
                    LinearGradient(colors: [Color("CardGradient1"), Color("CardGradient2")],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .cornerRadius(10)
                .padding()
                
            }
            .padding()
            
            if viewModel.isDialogVisible {
                CardAnimationDialog(isActive: $isActive)
            }
        }
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
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get: {
                        viewModel.cardNumber
                    }, set: { value in
                        viewModel.cardNumber = ""
                        let startIndex = value.startIndex
                        for index in 0..<value.count {
                            let stringIndex = value.index(startIndex, offsetBy: index)
                            viewModel.cardNumber += String(value[stringIndex])
                            
                            if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                                viewModel.cardNumber.insert(" ", at: stringIndex)
                            }
                            
                        }
                        
                        if value.last == " " {
                            viewModel.cardNumber.removeLast()
                        }
                        viewModel.cardNumber = String(viewModel.cardNumber.prefix(19))
                    }))
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
                    TextField("MM/YY", text: .init(get: {
                        viewModel.expireDate
                    }, set: { value in
                        
                        viewModel.expireDate = String(viewModel.expireDate.prefix(5))
                    }))
                    .keyboardType(.numberPad)
                    .focused($activeTF, equals: .expirationDate)
                    
                    Spacer(minLength: 0)
                    
                    TextField("CVV", text: $viewModel.cvvCode)
                        .frame(width: 35)
                        .focused($activeTF, equals: .ccv)
                        .keyboardType(.numberPad)
                    
                    Image(systemName: "questionmark.circle.fill")
                }
                .padding(.top, 15)
                
                Spacer(minLength: 0)
                
                TextField("CARD HOLDER NAME", text: $viewModel.cardHolderName)
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
    CardAddView(cards: .constant([]))
}


enum ActiveKeyboardField {
    case cardNumber
    case cardHolderName
    case expirationDate
    case ccv
}
