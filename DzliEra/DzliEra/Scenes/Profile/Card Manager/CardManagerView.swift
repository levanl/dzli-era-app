//
//  CardManagerView.swift
//  DzliEra
//
//  Created by Levan Loladze on 20.03.24.
//

import SwiftUI

struct CreditCard: Identifiable {
    let id = UUID()
    let holderName: String
    let cardNumber: String
    let cvvCode: String
    let expireDate: String
}

struct CardManagerView: View {
    @State private var cards: [CreditCard] = [
        CreditCard(holderName: "John Doe", cardNumber: "1234567812345678", cvvCode: "123", expireDate: "12/24"),
        CreditCard(holderName: "Jane Smith", cardNumber: "9876543298765432", cvvCode: "456", expireDate: "05/25")
    ]
    
    @State private var isShowingAddCardSheet = false
    
    var body: some View {
        VStack {
            List {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10]))
                        .frame(height: 200)
                    
                    Text("Add Your Card")
                        .font(.title2)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .onTapGesture {
                    isShowingAddCardSheet.toggle()
                }
                ForEach(cards) { card in
                    CardView(card: card)
                }
                .listRowSeparator(.hidden)
                .sheet(isPresented: $isShowingAddCardSheet) {
                    CardAddView()
                }
            }
            .listStyle(.plain)
        }
    }
}


#Preview {
    CardManagerView()
}


struct CardView: View {
    let card: CreditCard
    
    var formattedCardNumber: String {
        var formattedNumber = ""
        for i in 0..<card.cardNumber.count {
            formattedNumber.append(card.cardNumber[card.cardNumber.index(card.cardNumber.startIndex, offsetBy: i)])
            if i % 4 == 3 && i < card.cardNumber.count - 1 {
                formattedNumber.append(" ")
            }
        }
        return formattedNumber
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LinearGradient(colors: [Color("CardGradient1"), Color("CardGradient2")],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
            
            VStack(spacing: 10) {
                HStack {
                    Text(formattedCardNumber)
                    
                    Spacer(minLength: 0)
                    
                    Image("Visa")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 35)
                }
                
                HStack(spacing: 12) {
                    Text(card.expireDate)
                    
                    Spacer(minLength: 0)
                    
                    Text(card.cvvCode)
                    
                    Image(systemName: "questionmark.circle.fill")
                }
                .padding(.top, 15)
                
                Spacer(minLength: 0)
                
                Text(card.holderName)
            }
            .padding(20)
            .environment(\.colorScheme, .dark)
            .tint(.white)
        }
        .frame(height: 200)
        //    .padding(.top, 35)
    }
}
