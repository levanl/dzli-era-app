//
//  NiceJobView.swift
//  DzliEra
//
//  Created by Levan Loladze on 31.01.24.
//

import SwiftUI
import Vortex

struct NiceJobView: View, WithRootNavigationController {
    var workout: DoneWorkout
    @State private var isFireworksActive = false
    @ObservedObject var sharedViewModel = SharedViewModel.shared
    @State private var isOverlayVisible = true
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            
            Text("Nice Work!")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 30)
            
            VStack {
                TabView {
                    ForEach (0..<workout.images.count + 1) {  index in
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

                let newWorkout = PostedWorkout(userEmail: sharedViewModel.user?.email ?? "Default@gmail.com", time: String(workout.elapsedTime), reps: String(workout.totalReps), sets: "21", exercises: workout.exercises)
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
                    VortexView(createFireworks()) {
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
    
    func createFireworks() -> VortexSystem {
        let sparkles = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onUpdate,
            emissionLimit: 1,
            lifespan: 0.5,
            speed: 0.05,
            angleRange: .degrees(90),
            size: 0.05
        )
        
        let explosion = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onDeath,
            position: [0.5, 1],
            birthRate: 100_000,
            emissionLimit: 500,
            speed: 0.5,
            speedVariation: 1,
            angleRange: .degrees(360),
            acceleration: [0, 1.5],
            dampingFactor: 4,
            colors: .randomRamp(
                [.white, .pink, .pink],
                [.white, .blue, .blue],
                [.white, .green, .green],
                [.white, .orange, .orange],
                [.white, .cyan, .cyan]
            ),
            size: 0.15,
            sizeVariation: 0.1,
            sizeMultiplierAtDeath: 0
        )
        
        let mainSystem = VortexSystem(
            tags: ["circle"],
            secondarySystems: [sparkles, explosion],
            position: [0.5, 1],
            birthRate: 2,
            emissionLimit: 10,
            speed: 1.5,
            speedVariation: 0.75,
            angleRange: .degrees(60),
            dampingFactor: 2,
            size: 0.15,
            stretchFactor: 4
        )
        
        return mainSystem
    }
}


//struct NiceJobView_Previews: PreviewProvider {
//    static var previews: some View {
//        NiceJobView(workout: DoneWorkout(title: "abara", elapsedTime: 52, totalReps: 5, images: [UIImage(named: "onboarding1")!, UIImage(named: "onboarding2")!, UIImage(named: "onboarding3")!]))
//    }
//}


struct InfoBox: View {
    var title: String
    var value: String
    var icon: String?
    
    
    var body: some View {
        VStack {
            if let icon = icon {
                Image(icon)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
            }
            
            Text(value)
                .font(.title)
                .foregroundColor(.black)
            
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
