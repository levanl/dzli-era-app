//
//  MuscleChartViewComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI
import Charts

struct MuscleChartViewComponent: View {
    // MARK: - Properties
    let muscleSplitData: [MuscleSplit]
    
    // MARK: - Body
    var body: some View {
        Chart {
            ForEach(muscleSplitData) { data in
                BarMark(x: .value("count", data.count),
                        y: .value("muscleType", data.muscleType),
                        height: 10
                )
                .annotation(position: .trailing, alignment: .leading) {
                    Text("")
                        .foregroundStyle(Color.white)
                }
            }
        }
        .frame(height: 200)
        .chartYAxis {
            AxisMarks(values: .automatic) {
                AxisValueLabel()
                    .foregroundStyle(Color.white)
                    .font(.title3)
            }
        }
    }
}
