//
//  OnBoardingView.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct OnBoardingView: View, WithRootNavigationController {
    // MARK: - Properties
    @StateObject private var viewModel = OnBoardingViewModel()
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $viewModel.pageIndex) {
            ForEach(viewModel.pages) { page in
                VStack(spacing: 0) {
                    OnBoardingComponent(page: page)
                        .edgesIgnoringSafeArea(.top)
                        .overlay (
                            Group {
                                if page == viewModel.pages.last {
                                    Button(action: {
                                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")

                                        self.push(viewController: UIHostingController(rootView: SignInEmailView()), animated: true)
                                    }) {
                                        Text("Get Started")
                                            .font(.custom("Helvetica-Bold", size: 16))
                                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                    }
                                    .signUpButtonStyle
                                    .offset(y: 250)
                                } else {
                                    Button(action: {
                                        viewModel.incrementPage()
                                    }) {
                                        Text("Next")
                                            .font(.custom("Helvetica-Bold", size: 16))
                                            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44, maxHeight: 44, alignment: .center)
                                    }
                                    .signUpButtonStyle
                                    .offset(y: 250)
                                }
                            }
                        )
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut, value: viewModel.pageIndex)
        .tabViewStyle(.page)
        .edgesIgnoringSafeArea(.top)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear {
            viewModel.dotAppearance.currentPageIndicatorTintColor = .white
            viewModel.dotAppearance.pageIndicatorTintColor = .gray
            
            print(AuthenticationManager.shared.isUserLoggedIn())
        }
        .background(Color.black)
        
    }
}

#Preview {
    OnBoardingView()
}
