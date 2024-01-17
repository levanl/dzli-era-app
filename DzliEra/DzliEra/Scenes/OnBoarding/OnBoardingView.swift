//
//  OnBoardingView.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct testView: View {
    
    @State private var pageIndex = 0
    
    private let pages: [OnBoardingPageModel] = OnBoardingPageModel.sampleOnBoardingPages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    Spacer()
                    OnBoardingView(page: page)
                    Spacer()
                    if page == pages.last {
                        Button("Sign up", action: goToZero)
                    } else {
                        Button("next", action: incrementPage)
                    }
                    Spacer()
                }
                .tag(page.tag)
            }
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .black
            dotAppearance.pageIndicatorTintColor = .gray
        }
    }
    
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}

#Preview {
    OnBoardingView(page: OnBoardingPageModel.sampleOnBoarding)
}
