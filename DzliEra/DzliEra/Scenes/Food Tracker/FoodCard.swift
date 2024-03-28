//
//  FoodCard.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.03.24.
//

import SwiftUI

struct FoodCard: View {
    let width: CGFloat = 200
    @State var carbs: CGFloat = 25
    @State var protein: CGFloat = 80
    @State var fat: CGFloat = 40
    @State var name: String = ""
    @State var title: String = ""
    var body: some View {
        
        return VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("name")
                    .font(.title2)
                    .frame(width: 160)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
            .bold()
            HStack {
                Text("titles")
                Spacer()
            }
            .frame(width: 200, height: 30)
            .minimumScaleFactor(0.6)
        }
        .offset(x: 20, y: -20)
        .frame(width: 270, height: 110)
        .background(.white)
        .cornerRadius(10)
        .modifier(CustomShadow())
        .overlay(alignment: .bottom, content: {
            HStack {
                Elements(name: "carbs", foodElement: carbs)
                Elements(name: "protein", foodElement: protein)
                Elements(name: "fat", foodElement: fat)
            }
        })
    }
}

#Preview {
    FoodCard()
}


struct Elements: View {
    
    var name = "name"
    var foodElement: CGFloat = 100
    var color = ""
    
    var body: some View {
        let width: CGFloat = 130
        let multiplier = width / 200
        return VStack {
            Text(name)
                .font(.system(size: 12))
            Rectangle().frame(width: foodElement * multiplier,height: 5)
                .cornerRadius(5)
                .foregroundStyle(.yellow)
        }
        .padding(.bottom, 5)
        .frame(width: 90)
    }
}
