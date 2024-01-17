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
    
    static var sampleOnBoarding = OnBoardingPageModel(name: "Title Example", description: "hola como setas kete xola", imageURL: "onboard1", tag: 0)
    
    static var sampleOnBoardingPages: [OnBoardingPageModel] = [
        OnBoardingPageModel(name: "Welcome To Default App", description: "The Best app to get bigger", imageURL: "onboard1", tag: 0),
        OnBoardingPageModel(name: "Meet New People", description: "The Best app to get bigger", imageURL: "onboard2", tag: 1),
        OnBoardingPageModel(name: "Hazaki", description: "The Best app to get bigger", imageURL: "onboard1", tag: 2)
    ]
}
