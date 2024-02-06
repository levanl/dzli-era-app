//
//  EditProfileView.swift
//  DzliEra
//
//  Created by Levan Loladze on 06.02.24.
//

import SwiftUI

struct EditProfileView: View {
    
    @StateObject private var photoViewModel = PhotoPickerViewModel()
    @State private var isShowingActionSheet = false

    var body: some View {
        VStack {
            
            Image(systemName: "person.circle.fill")
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
            .confirmationDialog("Change Your Profile Picture", isPresented: $isShowingActionSheet, titleVisibility: .automatic) {
                Button("Select Library Photo") {}
                Button("Take Photo") {}
                
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("heyoo")
            }

            Spacer()
            
        }
    }
}

#Preview {
    EditProfileView()
}

struct ImagePickerView: View {
    var body: some View {
        VStack {
            Button(action: {
                // Handle select library photo action
            }) {
                Text("Select Library Photo")
            }
            Button(action: {
                // Handle take photo action
            }) {
                Text("Take Photo")
            }
            Button(action: {
                // Handle cancel action
            }) {
                Text("Cancel")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

final class PhotoPickerViewModel: ObservableObject {
    
}
