//
//  HomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import SwiftUI

struct HomeView: View {
    
    var postableWorkouts: [PostedWorkout]?
    
    var body: some View {
            Text("HomeView")
    
    }
}

#Preview {
    HomeView(postableWorkouts: [PostedWorkout(userEmail: "levexa@gmail.com", time: "55.10", reps: "12", sets: "12", exercises: [Exercise(name: "levana", bodyPart: "fexi", equipment: .bodyWeight, gifURL: "heyo", id: "soi", target: "delts")])])
}
