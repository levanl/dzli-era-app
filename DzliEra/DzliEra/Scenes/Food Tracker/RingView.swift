//
//  RingView.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.03.24.
//

import SwiftUI

struct CustomShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}

struct RingView: View {
    @EnvironmentObject var vm: CDDataModel
    var precent: CGFloat = 50
    let width: CGFloat = 130
    let height: CGFloat = 130
    var body: some View {
        let ringValue = vm.saveValueEntity.first
        let progress = 1 - (ringValue?.ring ?? 0 / 1000)
        return HStack(spacing: 40) {
            ZStack {
                Circle()
                    .stroke(Color.blue.opacity(0.1),style: StrokeStyle(lineWidth: 5))
                    .frame(width: width, height: height)
                Circle()
                    .trim(from: CGFloat(progress), to: 1)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color("cads"), .blue]), startPoint: .top, endPoint: .bottom), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                    .rotationEffect(Angle(degrees: 90))
                    .rotation3DEffect(
                        Angle(degrees: 180), axis: (x: 1, y: 0, z: 0)
                    )
                    .frame(width: width, height: height)
                Text("1920").bold()
                    .font(.title)
            }
            HStack(spacing: 30) {
                ForEach(vm.saveValueEntity) { item in
                    FoodElementalValue(element: "Carbs", gram: String(format: "%.0f", item.cards), color: "CardGradient2", elementValue: CGFloat(item.cards))
                    FoodElementalValue(element: "Fat", gram: String(format: "%.0f", item.fat), color: "CardGradient2", elementValue: CGFloat(item.fat))
                    FoodElementalValue(element: "Protein", gram: String(format: "%.0f", item.protein), color: "CardGradient2", elementValue: CGFloat(item.protein))
                }
            }
            
        }
        .frame(height: 180)
        .frame(width: UIScreen.main.bounds.width - 20)
        .background(Color.white)
        .cornerRadius(20)
        .modifier(CustomShadow())
    }
}

#Preview {
    RingView()
        .environmentObject(CDDataModel())
}


struct FoodElementalValue: View {
    
    var element = ""
    var gram = ""
    var color = ""
    var elementValue: CGFloat = 0
    
    var body: some View {
        let height: CGFloat = 130
        let multiplier = height / 2000
        return VStack {
            ZStack(alignment: .bottom){
                Rectangle()
                    .frame(width: 8, height: 110)
                    .foregroundStyle(.gray.opacity(0.5))
                if elementValue != 0 {
                    Rectangle()
                        .frame(width: 8, height: elementValue * multiplier)
                        .foregroundStyle(Color(color))
                } else {
                    Rectangle()
                        .frame(width: 8, height: 110)
                        .foregroundStyle(Color(color))
                }
            }
            .cornerRadius(10)
            
            Text(element)
                .font(.system(size: 12))
            Text(gram)
                .font(.system(size: 10))
        }
    }
}
