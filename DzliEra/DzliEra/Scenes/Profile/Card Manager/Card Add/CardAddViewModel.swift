//
//  CardAddViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.03.24.
//

import Foundation


final class CardAddViewModel: ObservableObject {
    
    @Published var cardNumber: String = ""
    @Published var cardHolderName: String = ""
    @Published var cvvCode: String = ""
    @Published var expireDate: String = ""
    @Published var isDialogVisible = false
    @Published var editingTextField1 = false
    @Published var editingTextField2 = false
    @Published var editingTextField3 = false
    @Published var editingTextField4 = false
    
    func addCard(cards: inout [CreditCard], dismiss: @escaping () -> Void) {
        let newCard = CreditCard(holderName: cardHolderName, cardNumber: cardNumber, cvvCode: cvvCode, expireDate: expireDate)
        cards.append(newCard)
        isDialogVisible = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isDialogVisible = false
            dismiss()
        }
    }
    
    func formatCardNumber(value: String) -> String {
            var formattedNumber = ""
            for i in 0..<value.count {
                formattedNumber.append(value[value.index(value.startIndex, offsetBy: i)])
                if i % 4 == 3 && i < value.count - 1 {
                    formattedNumber.append(" ")
                }
            }
            return formattedNumber
        }
}
