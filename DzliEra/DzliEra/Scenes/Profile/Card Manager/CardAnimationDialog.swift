//
//  CardAnimationDialog.swift
//  DzliEra
//
//  Created by Levan Loladze on 24.03.24.
//

import SwiftUI

struct CardAnimationDialog: View {
    @Binding var isActive: Bool

    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.7)
                .onTapGesture {
                    close()
                }
            LottieView(name: "CreditCard")
                .padding(30)
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        CardAnimationDialog(isActive: .constant(true))
    }
}
