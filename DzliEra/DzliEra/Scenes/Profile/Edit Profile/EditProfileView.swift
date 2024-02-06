//
//  EditProfileView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.02.24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @StateObject private var photoViewModel = PhotoPickerViewModel()
    @State private var isShowingActionSheet = false
    @State private var avatarImage: UIImage?
    @State var showPicker: Bool = false
    
    var body: some View {
        VStack {
            
            Image(uiImage: photoViewModel.selectedImage ?? UIImage(resource: .onboarding1))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.bottom, 10)
            
            
            
            Button(action: {
                self.isShowingActionSheet.toggle()
            }) {
                Text("Change Picture")
                    .foregroundColor(.blue)
            }
            .confirmationDialog("Profile Picture", isPresented: $isShowingActionSheet) {
                Button {
                    
                } label: {
                    Label("Camera", systemImage: "camera")
                }
                Button {
                    showPicker.toggle()
                } label: {
                    Label("Gallery", systemImage: "photo.artframe")
                }
            }
            .photosPicker(isPresented: $showPicker, selection: $photoViewModel.imageSelection)
            
            Spacer()
            
        }
    }
}

#Preview {
    EditProfileView()
}

final class PhotoPickerViewModel: ObservableObject {
    
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
    }
}
