//
//  StorageManager.swift
//  DzliEra
//
//  Created by Levan Loladze on 07.02.24.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    private init() { }
    
    private let storage = Storage.storage().reference()
    
    func saveImage(data: Data) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await storage.child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path,
              let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }

        return (returnedName, returnedPath)
    }
}
