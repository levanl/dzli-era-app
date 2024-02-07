//
//  ProfileChart.swift
//  DzliEra
//
//  Created by Levan Loladze on 04.02.24.
//

import SwiftUI
import Charts

struct SavingsModel: Identifiable {
    let id = UUID()
    
    var amount: Double
    let create: Date
}


struct ProfileChart: View {
    
    let list = [
        SavingsModel(amount: 14.0, create: Date()),
        SavingsModel(amount: 24.0, create: Date()),
        SavingsModel(amount: 50.0, create: Date()),
        SavingsModel(amount: 35.0, create: Date()),
        SavingsModel(amount: 67.0, create: Date())
    ]
    
    var body: some View {
        Chart (list) { savingModel in
            LineMark(x: .value("Month", savingModel.create),
                     y: .value("Dollar", savingModel.amount)
            ).foregroundStyle(.red)
        }
    }
}

#Preview {
    ProfileChart()
}
