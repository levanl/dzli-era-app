//
//  EditProfileView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.02.24.
//

import SwiftUI
import PhotosUI

// MARK: - EditProfileView
struct EditProfileView: View, WithRootNavigationController {
    
    // MARK: - Properties
    @StateObject private var photoLibraryViewModel = PhotoPickerViewModel()
    @StateObject private var viewModel = EditProfileViewModel()
    @State private var isShowingActionSheet = false
    @State private var avatarImage: UIImage?
    @State var showPicker: Bool = false
    @State private var imageData: Data? = nil
    
    // MARK: - Body
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
                    TextField("Enter your name", text: $viewModel.name)
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
                    TextField("Enter your bio", text: $viewModel.bio)
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
                    Picker(selection: $viewModel.selectedSexIndex, label: Text("")) {
                        ForEach(0 ..< viewModel.sexes.count, id: \.self) {
                            Text(self.viewModel.sexes[$0])
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
                
                let userId = viewModel.user?.userId ?? "nil"
                let name = viewModel.name
                let bio = viewModel.bio
                let sex = viewModel.sexes[viewModel.selectedSexIndex]
                let image = photoLibraryViewModel.selectedImage
                
                Task {
                    do {
                        try await UserManager.shared.updateUserProfile(userId: userId, name: name, bio: bio, sex: sex, image: image)
                        
                        if let item = photoLibraryViewModel.imageSelection {
                            viewModel.saveProfileImage(item: item)
                        } else {
                            print("Error: imageSelection is nil")
                        }
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
            
            Button(action: {
                Task {
                    do {
                        print(AuthenticationManager.shared.isUserLoggedIn())
                        
                        try viewModel.logOut()
                        self.push(viewController: UIHostingController(rootView: SignInEmailView()), animated: true)
                        print(AuthenticationManager.shared.isUserLoggedIn())
                    }
                    catch {
                        
                    }
                }
            }) {
                Text("log out")
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
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

