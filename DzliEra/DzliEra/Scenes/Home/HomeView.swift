//
//  HomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    static let shared = SharedViewModel()
    
    var user: DBUser?
    
    func fetchCurrentUser() {
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
            } catch {
                print("Error loading user: \(error)")
            }
        }
    }
    
    @Published var postableWorkouts: [PostedWorkout] = [PostedWorkout(userEmail: "example@gmail.com", time: "10", reps: "20", sets: "20", exercises: [Exercise(name: "rows", bodyPart: "fexi", equipment: .cable, gifURL: "onboarding1", id: "asiudaiu", target: "aodsoisahda"),Exercise(name: "rows", bodyPart: "fexi", equipment: .cable, gifURL: "onboarding1", id: "asiudaiu", target: "aodsoisahda")])]
    
    private init() {}
}

struct HomeView: View, WithRootNavigationController {
    
    @ObservedObject var sharedViewModel = SharedViewModel.shared
    
    var body: some View {
        NavigationView {
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
                        
                        
                        
                        List {
                            ForEach(workout.exercises, id: \.id) { exercise in
                                HStack(spacing: 10) {
                                    
                                    Image(exercise.gifURL)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    
                                    Text(exercise.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18))
                                }
                                .listRowBackground(AppColors.gray)
                                
                            }
                            
                        }
                        .listStyle(.plain)
                        
                        
                        Spacer()
                    }
                    .frame(height: 300)
                    .listRowBackground(AppColors.gray)
                    .onTapGesture {
                        self.push(viewController: UIHostingController(rootView: PostedWorkoutView(workout: workout)), animated: true)
                    }
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Your Title", displayMode: .inline)
            
        }
    }
}

#Preview {
    HomeView()
}
