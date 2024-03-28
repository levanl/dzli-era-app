//
//  FoodTrackerHomeView.swift
//  DzliEra
//
//  Created by Levan Loladze on 27.03.24.
//

import SwiftUI

struct FoodTrackerHomeView: View {
    @State private var user: DBUser? = nil
    @EnvironmentObject var vm: CDDataModel
    @State var itemSelected: Tab = .Breakfast
    @State var shouldShowBlurAndLock = true
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Text("Calorie Tracker").bold()
                            .font(.system(size: 35))
                        Spacer()
                        Image("Chicken")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50,height: 50)
                            .shadow(color: .blue, radius: 20, x: 0, y: 0)
                    }
                    .padding(.horizontal)
                    RingView()
                    Divider()
                    FoodTabView(itemselected: $itemSelected)
                    
                    if itemSelected == .Breakfast {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(vm.saveBreakfastEntity) { item in
                                    FoodCard(carbs: CGFloat(item.cards), protein: CGFloat(item.protein), fat: CGFloat(item.fat), name: item.name ?? "", title: item.ingredients ?? "")
                                        .padding(.leading)
                                        .overlay(alignment: .topTrailing, content: {
                                            Button(action: {}, label: {
                                                ZStack {
                                                    Circle()
                                                        .frame(width: 30, height: 30)
                                                }
                                            })
                                        })
                                }
                            }
                        }
                        
                    }
                    
                    WaterView()
                        .padding(.top, 50)
                    Spacer()
                }
                if shouldShowBlurAndLock {
                    BlurView()
                        .ignoresSafeArea()
                    
                    Image(systemName: "lock.fill")
                        .font(.largeTitle)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                    self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                    print("User loaded: \(self.user?.email ?? "Unknown email")")
                    
                    if user?.isPremium ?? true {
                        shouldShowBlurAndLock = false
                    } else {
                        shouldShowBlurAndLock = true

                    }
                } catch {
                    print("Error loading user: \(error)")
                }
            }
        }
    }
}

#Preview {
    FoodTrackerHomeView()
        .environmentObject(CDDataModel())
}


struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}
