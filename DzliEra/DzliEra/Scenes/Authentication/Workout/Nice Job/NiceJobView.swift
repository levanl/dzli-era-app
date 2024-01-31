//
//  NiceJobView.swift
//  DzliEra
//
//  Created by Levan Loladze on 31.01.24.
//

import SwiftUI
import EffectsLibrary

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
    }
}


struct NiceJobView_Previews: PreviewProvider {
    static var previews: some View {
        NiceJobView()
    }
}
