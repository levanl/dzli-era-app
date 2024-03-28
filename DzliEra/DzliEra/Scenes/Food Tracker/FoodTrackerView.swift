//
//  FoodTrackerView.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.03.24.
//

import SwiftUI

struct FoodTrackerView: View {
    @StateObject var vm: CDDataModel = CDDataModel()
    var body: some View {
        FoodTrackerHomeView()
            .environmentObject(CDDataModel())
    }
}

#Preview {
    FoodTrackerView()
}
