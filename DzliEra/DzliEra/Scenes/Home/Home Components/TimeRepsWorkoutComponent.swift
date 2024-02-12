//
//  TimeRepsWorkoutComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI

struct TimeRepsWorkoutComponent: View {
    // MARK: - Properties
    let workout: PostedWorkout
    
    // MARK: - Body
    var body: some View {
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
    }
}
