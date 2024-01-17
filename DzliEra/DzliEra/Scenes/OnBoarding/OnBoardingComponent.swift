//
//  OnBoardingComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct OnBoardingView: View {
    
    var page: OnBoardingPageModel
    
    var body: some View {
        VStack(spacing: 20) {

            Image("\(page.imageURL)")
                .resizable()
                .scaledToFit()
            Text(page.name)
                .font(.title)
            
            Text(page.description)
                .font(.subheadline)
                .frame(width: 300)
        }
    }
}

#Preview {
    OnBoardingView(page: OnBoardingPageModel.sampleOnBoarding)
}
