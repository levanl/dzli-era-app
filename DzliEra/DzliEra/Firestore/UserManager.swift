//
//  UserManager.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.01.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    var routines: [Routine]?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.routines = nil
    }
    
    init(
        userId: String,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        routines: [Routine]? = nil
    ) {
        self.userId = userId
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.routines = routines
    }
    
    mutating func addRoutine(_ routine: Routine) {
        if routines == nil {
            routines = [routine]
        } else {
            routines?.append(routine)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "user_isPremium"
        case routines = "routines"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.routines = try container.decodeIfPresent([Routine].self, forKey: .routines)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.routines, forKey: .routines)
    }
}

final class UserManager {
    
    static let shared = UserManager()
    private init() {  }
    
    private let userCollection = Firestore.firestore().collection("users")
    
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    func uploadRoutines(userId: String, routines: [Routine]) async throws {
        var routinesData: [[String: Any]] = []

        for routine in routines {
            let routineData: [String: Any] = [
                "title": routine.title,
                "exercises": try routine.exercises.map { try $0.toFirestoreData() }
            ]
            routinesData.append(routineData)
        }

        let data: [String: Any] = ["routines": routinesData]

        try await userDocument(userId: userId).setData(data, merge: true)
    }
    
    // MARK: - Get Routines for User
        func getRoutines(userId: String) async throws -> [Routine] {
            let document = userDocument(userId: userId)
            let documentSnapshot = try await document.getDocument()

            guard let data = try? documentSnapshot.data(as: DBUser.self) else {
                throw NSError(domain: "YourErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode user data."])
            }

            return data.routines ?? []
        }
}

extension Exercise {
    func toFirestoreData() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return dictionary ?? [:]
    }
}
