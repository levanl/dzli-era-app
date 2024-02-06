//
//  EditProfileView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.02.24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @StateObject private var photoLibraryViewModel = PhotoPickerViewModel()
    @State private var isShowingActionSheet = false
    @State private var avatarImage: UIImage?
    @State var showPicker: Bool = false
    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var sex: String = ""
    @State private var selectedSexIndex = 0
    
    let sexes = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack {
            
            Image(uiImage: photoLibraryViewModel.selectedImage ?? UIImage(resource: .onboarding1))
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
                    Label("Photo Library", systemImage: "photo.artframe")
                }
            }
            .photosPicker(isPresented: $showPicker, selection: $photoLibraryViewModel.imageSelection)
            
            VStack(alignment: .leading) {
                Text("Public Profile Data")
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .font(.headline)
                
                
                HStack {
                    Text("Name:")
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                    TextField("Enter your name", text: $name)
                        .foregroundColor(.white)
                        .frame(height: 80)
                        .padding(.trailing)
                }
                
                Divider()
                    .background(.white)
                
                HStack {
                    Text("Bio:")
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                    TextField("Enter your bio", text: $bio)
                        .foregroundColor(.white)
                        .frame(height: 80)
                        .padding(.trailing)
                }
                Divider()
                    .background(.white)
                
            }
            .padding(.top, 30)
            .padding(.bottom, 40)
            
            VStack(alignment: .leading) {
                Text("Private Data")
                    .foregroundColor(.gray)
                    .padding(.leading)
                    .font(.headline)
                
                HStack {
                    Text("Sex")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.trailing, 8)
                    Picker(selection: $selectedSexIndex, label: Text("")) {
                        ForEach(0 ..< sexes.count) {
                            Text(self.sexes[$0])
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(height: 50)
                    Spacer()
                }
                
                Divider()
                    .background(.white)
            }
            Spacer()
            
            Button(action: {
                // Implement save functionality here
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        
        
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
                    DispatchQueue.main.async { [weak self] in
                        self?.selectedImage = uiImage
                    }
                    return
                }
            }
        }
    }
}
