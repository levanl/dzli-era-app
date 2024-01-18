//
//  OnBoardingModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import Foundation

struct OnBoardingPageModel: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageURL: String
    var tag: Int
    
    static var sampleOnBoarding = OnBoardingPageModel(name: "Begin Your DzliEra", description: "Users can add their routines and share them with others.", imageURL: "onboarding1", tag: 0)
    
    static var sampleOnBoardingPages: [OnBoardingPageModel] = [
        OnBoardingPageModel(name: "Begin Your DzliEra", description: "Users can add their routines and share them with others.", imageURL: "onboarding1", tag: 0),
        OnBoardingPageModel(name: "Track Nutrition", description: "Food intake is important for staying healthy and supporting muscle growth.", imageURL: "onboarding2", tag: 0),
        OnBoardingPageModel(name: "Exercise Library", description: "A comprehensive exercise Library with instructions", imageURL: "onboarding3", tag: 2)
    ]
}
