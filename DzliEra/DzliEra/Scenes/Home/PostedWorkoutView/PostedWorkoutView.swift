//
//  PostedWorkoutView.swift
//  DzliEra
//
//  Created by Levan Loladze on 04.02.24.
//

import SwiftUI
import Charts

struct PostedWorkoutView: View {
    
    let workout: PostedWorkout
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                
                Text(workout.userEmail)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 20)
            
            HStack(spacing: 20) {
                
                VStack(spacing: 3) {
                    Text("Time")
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                    Text(workout.time)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    
                }
                
                VStack(spacing: 3) {
                    Text("Reps")
                        .foregroundStyle(.gray)
                        .font(.system(size: 14))
                    Text(workout.reps)
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .overlay(.pink)
            
            let chartData: [MuscleSplit] = workout.exercises.reduce(into: [:]) { counts, exercise in
                counts[exercise.target, default: 2] += 1
            }
            .map { MuscleSplit(muscleType: $0.key, count: $0.value) }
            
            Chart {
                ForEach(chartData) { data in
                    BarMark(x: .value("count", data.count),
                            y: .value("muscleType", data.muscleType),
                            height: 10
                    )
                    
                    .annotation(position: .trailing, alignment: .leading) {
                        Text("33%")
                            .foregroundStyle(Color.white)
                    }
                    
                }
            }
            .frame(height: 200)
            .chartYAxis {AxisMarks(values: .automatic) {
                AxisValueLabel()
                    .foregroundStyle(Color.white)
                    .font(.title3)
                }
            }

            Spacer()
            
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    PostedWorkoutView(workout: PostedWorkout(userEmail: "blach@gmail.com", time: "10", reps: "20", sets: "32", exercises: [Exercise(name: "rows", bodyPart: "fexi", equipment: .cable, gifURL: "onboarding1", id: "asiudaiu", target: "aodsoisahda"),Exercise(name: "FEXi", bodyPart: "fexi", equipment: .cable, gifURL: "onboarding1", id: "asiudaiu", target: "LOMI")]))
}


struct MuscleSplit: Identifiable {
    let id = UUID()
    
    let muscleType: String
    let count: Int
}
