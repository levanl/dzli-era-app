//
//  OnBoardingViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 18.01.24.
//

import SwiftUI

final class OnBoardingViewModel: ObservableObject {
    // MARK: - Properties
    @Published var pageIndex = 0
    @Published var pages: [OnBoardingPageModel] = OnBoardingPageModel.sampleOnBoardingPages
    @Published var dotAppearance = UIPageControl.appearance()
    
    
    // MARK: - Methods
    func incrementPage() {
        pageIndex += 1
    }
    
    func goToZero() {
        pageIndex = 0
    }
}


