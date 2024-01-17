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
    
    static var sampleOnBoarding = OnBoardingPageModel(name: "Title Example", description: "hola como setas kete xola", imageURL: "onboarding1", tag: 0)
    
    static var sampleOnBoardingPages: [OnBoardingPageModel] = [
        OnBoardingPageModel(name: "Welcome To DzliEra App", description: "Science-backed workouts that get better as you do", imageURL: "onboarding1", tag: 0),
        OnBoardingPageModel(name: "Meet New People", description: "The Best app to get bigger", imageURL: "onboarding2", tag: 1),
        OnBoardingPageModel(name: "Hazaki", description: "The Best app to get bigger", imageURL: "onboarding3", tag: 2)
    ]
}
