//
//  OnBoardingModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import Foundation

struct OnBoardingPageModel: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var imageURL: String
    var tag: Int
}
