//
//  HomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import SwiftUI

class SharedViewModel: ObservableObject {
    static let shared = SharedViewModel()
    
    @Published var postableWorkouts: [PostedWorkout] = []
    
    
    var user: DBUser?
    
    func fetchCurrentUser() {
        
        print("fetch user called")
        Task {
            do {
                
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
                
                print("fetch user finished")
            } catch {
                print("Error loading user: \(error)")
            }
        }
    }
    

//    func fetchPostedWorkouts() {
//
//        print("PostedWorkout sTArted")
//        Task {
//            do {
//
//                DispatchQueue.main.async {
//                    self.postableWorkouts = fetchedWorkouts
//                }
//
//                print("PostedWorkout done")
//            } catch {
//                print("Error fetching posted workouts: \(error.localizedDescription)")
//            }
//        }
//    }
//
    
    
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
                                .listRowBackground(AppColors.secondaryBackgroundColor)
                                
                            }
                            
                        }
                        .listStyle(.plain)
                        
                        
                        Spacer()
                    }
                    .frame(height: 300)
                    .listRowBackground(AppColors.secondaryBackgroundColor)
                    .onTapGesture {
                        self.push(viewController: UIHostingController(rootView: PostedWorkoutView(workout: workout)), animated: true)
                    }
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(AppColors.backgroundColor)
            .task {
//                SharedViewModel.shared.fetchPostedWorkouts()
            }
        }
    }
}

#Preview {
    HomeView()
}
