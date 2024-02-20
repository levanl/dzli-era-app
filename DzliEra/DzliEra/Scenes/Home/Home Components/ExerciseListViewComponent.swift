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
                    AsyncImageView(url: exercise.gifURL)
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

struct AsyncImageView: View {
    let url: String
    @State private var imageData: Data?
    
    var body: some View {
        if let imageData = imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    loadImage()
                }
        } else {
            Image("DzlieraImageHolder")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}
