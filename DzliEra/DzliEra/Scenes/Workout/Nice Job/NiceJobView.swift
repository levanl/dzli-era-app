//
//  NiceJobView.swift
//  DzliEra
//
//  Created by Levan Loladze on 31.01.24.
//

import SwiftUI
// Vortex is animations library and used only for animations.
import Vortex

// MARK: - NiceJobView
struct NiceJobView: View, WithRootNavigationController {
    
    // MARK: - Properties
    var workout: DoneWorkout
    @State private var isFireworksActive = false
    @ObservedObject var sharedViewModel = PostedWorkoutViewModel.shared
    @StateObject var viewModel = NiceJobViewModel()
    
    @State private var isOverlayVisible = true
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            Text("Nice Work!")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 30)
            
            VStack {
                TabView {
                    ForEach (0..<workout.images.count + 1, id: \.self) {  index in
                        if index == 0 {
                            VStack(alignment: .leading) {
                                Text("Summary")
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 24)
                                    .padding(.bottom, 46)
                                
                                
                                HStack {
                                    InfoBox(title: "Duration", value: "\(workout.elapsedTime)",icon: "Timer")
                                    Spacer()
                                    InfoBox(title: "Exercises", value: "\(workout.totalReps)",icon: "Kunti")
                                }
                                .padding(.horizontal, 12)
                                
                                HStack {
                                    InfoBox(title: "Sets", value: "\(workout.totalReps)", icon: "Repeat")
                                    Spacer()
                                    InfoBox(title: "Volume", value: "\(workout.totalReps)",icon: "wona")
                                }
                                .padding(.horizontal, 12)
                                
                                Spacer()
                            }
                            
                        } else {
                            Image(uiImage: workout.images[index - 1])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 380, height: 450)
                                .clipped()
                            
                        }
                    }
                }
                .background(.white)
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .frame(height: 450)
            }
            .padding(.horizontal, 10)
            
            Spacer()
            Button(action: {
                let newWorkout = PostedWorkout(userEmail: sharedViewModel.user?.email ?? "Default@gmail.com", time: String(workout.elapsedTime), reps: String(workout.totalReps), sets: String(workout.totalSets), exercises: workout.exercises)
                Task {
                    do {
                        sharedViewModel.user?.addPostedWorkout(newWorkout)
                        try await UserManager.shared.uploadPostedWorkout(userId: sharedViewModel.user?.userId ?? "", postedWorkouts: sharedViewModel.user?.postedWorkouts ?? [])
                        try await UserManager.shared.savePostedWorkoutsToCollection(postedWorkouts: sharedViewModel.user?.postedWorkouts ?? [])
                    }
                    catch {
                        print("error")
                    }
                }
                sharedViewModel.postableWorkouts.append(newWorkout)
                presentationMode.wrappedValue.dismiss()
                self.push(viewController: TabController(), animated: true)
                
            }) {
                Text("Done")
                    .font(.custom("Helvetica-Bold", size: 20))
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(isOverlayVisible ? AppColors.gray : AppColors.authButtonColor)
            .cornerRadius(10)
            .shadow(color: Color.blue.opacity(0.5), radius: 10, x: 0, y: 5)
            .padding(.horizontal, 10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { _ in
                isOverlayVisible = false
            }
            sharedViewModel.fetchCurrentUser()
        }
        .overlay(
            Group {
                if isOverlayVisible {
                    VortexView(viewModel.createFireworks()) {
                        Circle()
                            .fill(.white)
                            .frame(width: 32)
                            .tag("circle")
                    }
                    .ignoresSafeArea()
                }
            }
        )
    }
}

