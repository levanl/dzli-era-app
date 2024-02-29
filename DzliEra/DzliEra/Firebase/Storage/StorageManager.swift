//
//  StorageManager.swift
//  DzliEra
//
//  Created by Levan Loladze on 07.02.24.
//

import Foundation
import FirebaseStorage

// MARK: - StorageManager
final class StorageManager {
    
    // MARK: - Singleton Reference
    static let shared = StorageManager()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Firesotre Document References
    private let storage = Storage.storage().reference()
    
    private var imagesReference: StorageReference {
        storage.child("images")
    }
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("users").child(userId)
    }
    
    // MARK: - Save Image to Firebase
    func saveImage(data: Data, userId: String) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path,
              let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }

        return (returnedName, returnedPath)
    }
    
    // MARK: - Get Image From Firebase
    func getData(userId: String, path: String) async throws -> Data {
        try await userReference(userId: userId).child(path).data(maxSize: 3 * 1024 * 1024)
    }
}
