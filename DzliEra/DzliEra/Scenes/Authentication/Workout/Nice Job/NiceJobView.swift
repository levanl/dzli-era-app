//
//  NiceJobView.swift
//  DzliEra
//
//  Created by Levan Loladze on 31.01.24.
//

import SwiftUI
import Vortex

struct NiceJobView: View {
    var workout: DoneWorkout?
    
    @State private var isConfettiActive = false
    
    var body: some View {
        VStack {
            Text("Good job!")
                .font(.title)
                .foregroundColor(.white)
            
            
            Spacer()
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .overlay(
            VortexView(createFireworks()
                      ) {
                          Circle()
                              .fill(.white)
                              .frame(width: 32)
                              .tag("circle")
                      }
                .ignoresSafeArea()
        )
        
    }
    
    func createFireworks() -> VortexSystem {
        let sparkles = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onUpdate,
            emissionLimit: 1,
            lifespan: 0.5,
            speed: 0.05,
            angleRange: .degrees(90),
            size: 0.05
        )
        
        let explosion = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onDeath,
            position: [0.5, 1],
            birthRate: 100_000,
            emissionLimit: 500,
            speed: 0.5,
            speedVariation: 1,
            angleRange: .degrees(360),
            acceleration: [0, 1.5],
            dampingFactor: 4,
            colors: .randomRamp(
                [.white, .pink, .pink],
                [.white, .blue, .blue],
                [.white, .green, .green],
                [.white, .orange, .orange],
                [.white, .cyan, .cyan]
            ),
            size: 0.15,
            sizeVariation: 0.1,
            sizeMultiplierAtDeath: 0
        )
        
        let mainSystem = VortexSystem(
            tags: ["circle"],
            secondarySystems: [sparkles, explosion],
            position: [0.5, 1],
            birthRate: 2,
            emissionLimit: 10,
            speed: 1.5,
            speedVariation: 0.75,
            angleRange: .degrees(60),
            dampingFactor: 2,
            size: 0.15,
            stretchFactor: 4
        )
        
        return mainSystem
    }
}


struct NiceJobView_Previews: PreviewProvider {
    static var previews: some View {
        NiceJobView()
    }
}
