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
    
    @FocusState private var activeTF: ActiveKeyboardField!
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var cvvCode: String = ""
    @State private var expireDate: String = ""
    @State private var editingTextField1 = false {
        didSet {
            guard editingTextField1 != oldValue else {
                return
            }
            if editingTextField1 {
                editingTextField2 = false
            }
        }
    }
    
    @State private var editingTextField2 = false {
        didSet {
            guard editingTextField2 != oldValue else {
                return
            }
            if editingTextField2 {
                editingTextField1 = false
            }
        }
    }
    
    @State private var editingTextField3 = false {
        didSet {
            guard editingTextField1 != oldValue else {
                return
            }
            if editingTextField1 {
                editingTextField2 = false
            }
        }
    }
    
    @State private var editingTextField4 = false {
        didSet {
            guard editingTextField2 != oldValue else {
                return
            }
            if editingTextField2 {
                editingTextField1 = false
            }
        }
    }
    
    private func formatCardNumber(value: String) -> String {
        var formattedNumber = ""
        for i in 0..<value.count {
          formattedNumber.append(value[value.index(value.startIndex, offsetBy: i)])
          if i % 4 == 3 && i < value.count - 1 {
            formattedNumber.append(" ")
          }
        }
        return formattedNumber
      }
    
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
            VStack {
                MaterialDesignTextField($cardNumber, placeholder: "Card Number", editing: $editingTextField1)
                    .padding()
                    .keyboardType(.numberPad)
                    .onTapGesture { editingTextField1 = true
                        editingTextField2 = false
                        editingTextField3 = false
                        editingTextField4 = false
                    }
                
                MaterialDesignTextField($cardHolderName, placeholder: "Name On Card", editing: $editingTextField2)
                    .padding()
                    .onTapGesture { editingTextField2 = true
                        editingTextField1 = false
                        editingTextField3 = false
                        editingTextField4 = false
                    }
                HStack(spacing: 0){
                    MaterialDesignTextField($cardHolderName, placeholder: "Expiry Date", editing: $editingTextField3)
                        .padding()
                        .onTapGesture { editingTextField3 = true
                            editingTextField1 = false
                            editingTextField2 = false
                            editingTextField4 = false
                        }
                    
                    MaterialDesignTextField($cardHolderName, placeholder: "Security Code", editing: $editingTextField4)
                        .padding()
                        .onTapGesture { editingTextField4 = true
                            editingTextField1 = false
                            editingTextField3 = false
                            editingTextField2 = false
                        }
                }
                
            }
            .padding(0)
            
            .onTapGesture {
                editingTextField1 = false
                editingTextField2 = false
            }
            
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
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get: {
                        cardNumber
                    }, set: { value in
                        cardNumber = ""
                        let startIndex = value.startIndex
                        for index in 0..<value.count {
                            let stringIndex = value.index(startIndex, offsetBy: index)
                            cardNumber += String(value[stringIndex])
                            
                            if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                                cardNumber.insert(" ", at: stringIndex)
                            }
                            
                        }
                        
                        if value.last == " " {
                            cardNumber.removeLast()
                        }
                        cardNumber = String(cardNumber.prefix(19))
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
                        expireDate
                    }, set: { value in
                        
                        expireDate = String(expireDate.prefix(5))
                    }))
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
                
                TextField("CARD HOLDER NAME", text: $cardHolderName)
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
    CardAddView()
}


enum ActiveKeyboardField {
    case cardNumber
    case cardHolderName
    case expirationDate
    case ccv
}

struct MaterialDesignTextField: View {
    
    var body: some View {
        ZStack {
            TextField("", text: $text)
              .onChange(of: text) { value in
                if value.count > 16 {
                  text = String(value.prefix(16))
                }
              }                .padding(10.0)
                .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                    .stroke(borderColor, lineWidth: borderWidth))
                .focused($focusField, equals: .textField)
            HStack {
                ZStack {
                    Color(.white)
                        .cornerRadius(4.0)
                    Text(placeholder)
                        .foregroundColor(.white)
                        .colorMultiply(placeholderColor)
                        .animatableFont(size: placeholderFontSize)
                        .padding(2.0)
                        .layoutPriority(1)
                }
                .padding([.leading], 2.0)
                .padding([.bottom], placeholderBottomPadding)
                
                Spacer()
            }
        }
        .onChange(of: editing) {
            focusField = $0 ? .textField : nil
            withAnimation(.easeOut(duration: 0.1)) {
                updateBorder()
                updatePlaceholder()
            }
        }
        .frame(width: .infinity, height: customHeight)
    }
    private let placeholder: String
    @State private var borderColor = Color.gray
    @State private var borderWidth = 1.0
    @Binding private var editing: Bool
    @FocusState private var focusField: Field?
    @State private var placeholderBackgroundOpacity = 0.0
    @State private var placeholderBottomPadding = 0.0
    @State private var placeholderColor = Color.gray
    @State private var placeholderFontSize = 16.0
    @State private var placeholderLeadingPadding = 3.0
    @Binding private var text: String
    
    private let customHeight: CGFloat
    
    init(_ text: Binding<String>, placeholder: String, editing: Binding<Bool>, customHeight: CGFloat = 25.0) {
        self._text = text
        self.placeholder = placeholder
        self._editing = editing
        self.customHeight = customHeight
    }
    
    private func updateBorder() {
        updateBorderColor()
        updateBorderWidth()
    }
    
    private func updateBorderColor() {
        borderColor = editing ? .blue : .gray
    }
    
    private func updateBorderWidth() {
        borderWidth = editing ? 2.0 : 1.0
    }
    
    private func updatePlaceholder() {
        updatePlaceholderBackground()
        updatePlaceholderColor()
        updatePlaceholderFontSize()
        updatePlaceholderPosition()
    }
    
    private func updatePlaceholderBackground() {
        placeholderBackgroundOpacity = (editing || !text.isEmpty) ? 1.0 : 0.0
    }
    
    private func updatePlaceholderColor() {
        placeholderColor = editing ? .blue : .gray
    }
    
    private func updatePlaceholderFontSize() {
        placeholderFontSize = (editing || !text.isEmpty) ? 14.0 : 16.0
    }
    
    private func updatePlaceholderPosition() {
        if editing || !text.isEmpty {
            placeholderBottomPadding = 40.0
            placeholderLeadingPadding = 8.0
        } else {
            placeholderBottomPadding = 0.0
            placeholderLeadingPadding = 8.0
        }
    }
    
    private enum Field {
        case textField
    }
    
}


struct AnimatableCustomFontModifier: AnimatableModifier {
    
    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
    }
    
}

extension View {
    func animatableFont(size: CGFloat) -> some View {
        modifier(AnimatableCustomFontModifier(size: size))
    }
}
