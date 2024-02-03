//
//  HomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    static let shared = SharedViewModel()

    @Published var postableWorkouts: [PostedWorkout] = [PostedWorkout(userEmail: "example@gmail.com", time: "10", reps: "20", sets: "20")]

    private init() {}
}

struct HomeView: View {
    
    @ObservedObject var sharedViewModel = SharedViewModel.shared
    
    var body: some View {
        VStack {
            List(sharedViewModel.postableWorkouts, id: \.id) { workout in
                Text(workout.sets)
            }
        }
    }
}

#Preview {
    HomeView()
}
