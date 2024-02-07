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
    @StateObject private var viewModel = EditProfileViewModel()
    
    @State private var isShowingActionSheet = false
    @State private var avatarImage: UIImage?
    @State var showPicker: Bool = false
    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var sex: String = ""
    @State private var selectedSexIndex = 0
    @State private var imageData: Data? = nil
    let sexes = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack {
            
            if let imageData = imageData {
                Image(uiImage: UIImage(data: imageData) ?? UIImage(resource: .onboarding1))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.bottom, 10)
            } else {
                Image(uiImage: photoLibraryViewModel.selectedImage ?? UIImage(resource: .onboarding1))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.bottom, 10)
            }
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
                Task {
                    do {
                        try await UserManager.shared.updateUserProfile(userId: viewModel.user?.userId ?? "nil", name: name, bio: bio, sex: sexes[selectedSexIndex], image: photoLibraryViewModel.selectedImage)
                        
                        viewModel.saveProfileImage(item: photoLibraryViewModel.imageSelection!)
                        print("Profile updated successfully!")
                    } catch {
                        print("Error updating profile: \(error.localizedDescription)")
                    }
                }
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
        .onAppear {
            viewModel.fetchCurrentUser()
            
            if let path = viewModel.user?.profileImagePath, let userId = viewModel.user?.userId {
                
                Task {
                    let data = try await StorageManager.shared.getData(userId: userId, path: path)
                    self.imageData = data
                }
                
            }
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
                    DispatchQueue.main.async { [weak self] in
                        self?.selectedImage = uiImage
                    }
                    return
                }
            }
        }
    }
}

final class EditProfileViewModel: ObservableObject {
    
    var user: DBUser?
    
    func fetchCurrentUser() {
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.getAuthenticatedUser()
                self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
                print("User loaded: \(self.user?.email ?? "Unknown email")")
            } catch {
                print("Error loading user: \(error)")
            }
        }
    }
    
    func saveProfileImage(item: PhotosPickerItem) {
        
        
        Task {
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, name) = try await StorageManager.shared.saveImage(data: data, userId: user?.userId ?? "nil")
            print("SUCCESS")
            print(path)
            print(name)
            try await UserManager.shared.updateUserProfileImage(userId: user?.userId ?? "ravime", path: name)
        }
        
    }
}
