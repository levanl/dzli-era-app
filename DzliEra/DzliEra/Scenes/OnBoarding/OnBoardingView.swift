//
//  OnBoardingView.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct OnBoardingView: View {
    
    @State private var pageIndex = 0
    
    private let pages: [OnBoardingPageModel] = OnBoardingPageModel.sampleOnBoardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack(spacing: 0) {
                    OnBoardingComponent(page: page)
                        .edgesIgnoringSafeArea(.top)
                        .overlay (
                            Group {
                                if page == pages.last {
                                    Button("Sign up", action: goToZero)
                                        .signUpButtonStyle
                                        .offset(y: 250)
                                }
                            }
                        )
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .edgesIgnoringSafeArea(.top)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .white
            dotAppearance.pageIndicatorTintColor = .gray
        }
        .background(Color.black)
        
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

#Preview {
    OnBoardingView()
}
