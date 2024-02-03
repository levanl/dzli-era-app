//
//  HomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    static let shared = SharedViewModel()
    
    @Published var postableWorkouts: [PostedWorkout] = [PostedWorkout(userEmail: "example@gmail.com", time: "10", reps: "20", sets: "20", exercises: [Exercise(name: "rows", bodyPart: "fexi", equipment: .cable, gifURL: "aisia", id: "asiudaiu", target: "aodsoisahda")])]
    
    private init() {}
}

struct HomeView: View {
    
    @ObservedObject var sharedViewModel = SharedViewModel.shared
    
    var body: some View {
        
        List {
            ForEach(sharedViewModel.postableWorkouts, id: \.id) { workout in
                
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
                    
                    List(workout.exercises, id: \.id) { exercise in
                        Text(exercise.name)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                    }
                    
                    Spacer()
                }
                .frame(width: .infinity, height: 300)
                .listRowBackground(AppColors.gray)
                
            }
        }
        .listRowBackground(AppColors.gray)
        .scrollContentBackground(.hidden)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        
        
    }
}

#Preview {
    HomeView()
}
