//
//  OnBoardingComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct OnBoardingComponent: View {
    
    var page: OnBoardingPageModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image("\(page.imageURL)")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.top)
            
            Text(page.name)
                .font(.custom("Helvetica-Bold", size: 45))
                .kerning(1)
                .frame(width: 300)
                .multilineTextAlignment(.center)
                .padding(.bottom, 25)
            
            Text(page.description)
                .font(.custom("Helvetica-Light", size: 16))
                .multilineTextAlignment(.center)
                .frame(width: 300)
            
            Spacer()
        }
        .background(Color.black)
        .foregroundColor(Color.white)
        
    }
}

#Preview {
    OnBoardingComponent(page: OnBoardingPageModel.sampleOnBoarding)
}
