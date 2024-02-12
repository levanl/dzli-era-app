//
//  UserWorkoutInfoComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI

struct UserWorkoutInfoComponent: View {
    // MARK: - Properties
    let workout: PostedWorkout
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .padding(.top, 8)
            
            Text(workout.userEmail)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 20)
    }
}
