//
//  ExerciseListViewComponent.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI

struct ExerciseListViewComponent: View {
    // MARK: - Properties
    let exercises: [Exercise]
    
    // MARK: - Body
    var body: some View {
        List {
            ForEach(exercises) { exercise in
                HStack(spacing: 10) {
                    Image(exercise.gifURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    Text(exercise.name)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                }
                .listRowBackground(AppColors.secondaryBackgroundColor)
            }
        }
        .listStyle(.plain)
    }
}
