//
//  OnBoardingView.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct OnBoardingView: View {
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
                                        
                                    }) {
                                        Text("Get Started")
                                            .font(.custom("Helvetica-Bold", size: 16))
                                    }
                                    .signUpButtonStyle
                                    .offset(y: 250)
                                } else {
                                    Button(action: {
                                        viewModel.incrementPage()
                                    }) {
                                        Text("Next")
                                            .font(.custom("Helvetica-Bold", size: 16))
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
        }
        .background(Color.black)
        
    }
}

#Preview {
    OnBoardingView()
}
