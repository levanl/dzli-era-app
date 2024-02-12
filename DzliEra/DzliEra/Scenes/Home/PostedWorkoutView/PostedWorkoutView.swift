//
//  PostedWorkoutView.swift
//  DzliEra
//
//  Created by Levan Loladze on 04.02.24.
//

import SwiftUI
import Charts

struct PostedWorkoutView: View {
    // MARK: - Properties
    @StateObject private var viewModel = PostedWorkoutInfoViewModel()
    let workout: PostedWorkout
    
    // MARK: - Body
    var body: some View {
        VStack {
            UserWorkoutInfoComponent(workout: workout)
            
            TimeRepsWorkoutComponent(workout: workout)
            
            Divider().overlay(Color.pink)
            
            MuscleChartViewComponent(muscleSplitData: viewModel.calculateMuscleSplitData(workout.exercises))
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

