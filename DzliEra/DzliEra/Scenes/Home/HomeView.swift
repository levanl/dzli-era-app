//
//  HomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import SwiftUI

struct HomeView: View, WithRootNavigationController {
    // MARK: - Properties
    @ObservedObject var sharedViewModel = PostedWorkoutViewModel.shared
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(sharedViewModel.postableWorkouts, id: \.id) { workout in
                    WorkoutInfoComponent(workout: workout)
                        .onTapGesture {
                            self.push(viewController: UIHostingController(rootView: PostedWorkoutView(workout: workout)), animated: true)
                        }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(AppColors.backgroundColor)
        }
    }
}
#Preview {
    HomeView()
}




