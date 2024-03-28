//
//  FoodTabView.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.03.24.
//

import SwiftUI

struct FoodSelected: Identifiable {
    var id = UUID()
    var food: String
    var tab: Tab
}

enum Tab: String {
    case Breakfast
    case Lunch
    case Dinner
    case Snacks
}

var selectedTab: [FoodSelected]  = [
    FoodSelected(food: "Breakfast", tab: .Breakfast),
    FoodSelected(food: "Lunch", tab: .Lunch),
    FoodSelected(food: "Dinner", tab: .Dinner),
    FoodSelected(food: "Snacks", tab: .Snacks)
    
]

struct FoodTabView: View {
    
    @Binding var itemselected: Tab
    var body: some View {
        HStack {
            ForEach(selectedTab) { item in
                Button(action: {
                    withAnimation {
                        itemselected = item.tab
                    }
                    
                }, label: {
                    Text(item.food)
                        .foregroundStyle(itemselected == item.tab ? .white : .black)
                        .padding(8)
                        .background(itemselected == item.tab ? .black : Color(""))
                        .cornerRadius(10)
                })
            }
        }
    }
}

#Preview {
    FoodTabView(itemselected: .constant(.Breakfast))
}
