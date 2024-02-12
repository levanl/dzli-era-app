//
//  WorkoutInfoComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI

struct WorkoutInfoComponent: View {
    // MARK: - Properties
    let workout: PostedWorkout
    
    // MARK: - Body
    var body: some View {
        VStack {
            UserWorkoutInfoComponent(workout: workout)
            
            TimeRepsWorkoutComponent(workout: workout)
            
            Divider().overlay(Color.pink)
            
            ExerciseListViewComponent(exercises: workout.exercises)
            
            Spacer()
        }
        .frame(height: 300)
        .padding(.bottom, 30)
        .listRowBackground(AppColors.secondaryBackgroundColor)
    }
}
