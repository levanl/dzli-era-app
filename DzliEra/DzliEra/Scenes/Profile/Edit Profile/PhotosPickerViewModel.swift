//
//  PhotosPickerViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import SwiftUI
import UIKit
import PhotosUI

// MARK: - PhotoPickerViewModel
final class PhotoPickerViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    // MARK: - Methods
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        self?.selectedImage = uiImage
                    }
                    return
                }
            }
        }
    }
}
