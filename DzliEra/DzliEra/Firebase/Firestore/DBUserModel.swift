//
//  DbUserModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import Foundation

// MARK: - DBUser Model
struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoUrl: String?
    let dateCreated: Date?
    let isPremium: Bool?
    var routines: [Routine]?
    var postedWorkouts: [PostedWorkout]?
    var name: String?
    var bio: String?
    var sex: String?
    let profileImagePath: String?
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoUrl = auth.photoUrl
        self.dateCreated = Date()
        self.isPremium = false
        self.routines = nil
        self.postedWorkouts = nil
        self.name = nil
        self.bio = nil
        self.sex = nil
        self.profileImagePath = nil
    }
    
    init(
        userId: String,
        email: String? = nil,
        photoUrl: String? = nil,
        dateCreated: Date? = nil,
        isPremium: Bool? = nil,
        routines: [Routine]? = nil,
        postedWorkouts: [PostedWorkout]? = nil,
        name: String? = nil,
        bio: String? = nil,
        sex: String? = nil,
        profileImagePath: String? = nil
    ) {
        self.userId = userId
        self.email = email
        self.photoUrl = photoUrl
        self.dateCreated = dateCreated
        self.isPremium = isPremium
        self.routines = routines
        self.postedWorkouts = postedWorkouts
        self.name = name
        self.bio = bio
        self.sex = sex
        self.profileImagePath = profileImagePath
    }
    
    mutating func addRoutine(_ routine: Routine) {
        if routines == nil {
            routines = [routine]
        } else {
            routines?.append(routine)
        }
    }
    
    mutating func addPostedWorkout(_ workout: PostedWorkout) {
        if postedWorkouts == nil {
            postedWorkouts = [workout]
        } else {
            postedWorkouts?.append(workout)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case email = "email"
        case photoUrl = "photo_url"
        case dateCreated = "date_created"
        case isPremium = "user_isPremium"
        case routines = "routines"
        case postedWorkouts = "posted_workouts"
        case name = "name"
        case bio = "bio"
        case sex = "sex"
        case profileImagePath = "profile_image_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.photoUrl = try container.decodeIfPresent(String.self, forKey: .photoUrl)
        self.dateCreated = try container.decodeIfPresent(Date.self, forKey: .dateCreated)
        self.isPremium = try container.decodeIfPresent(Bool.self, forKey: .isPremium)
        self.routines = try container.decodeIfPresent([Routine].self, forKey: .routines)
        self.postedWorkouts = try container.decodeIfPresent([PostedWorkout].self, forKey: .postedWorkouts)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.sex = try container.decodeIfPresent(String.self, forKey: .sex)
        self.profileImagePath = try container.decodeIfPresent(String.self, forKey: .profileImagePath)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.userId, forKey: .userId)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
        try container.encodeIfPresent(self.dateCreated, forKey: .dateCreated)
        try container.encodeIfPresent(self.isPremium, forKey: .isPremium)
        try container.encodeIfPresent(self.routines, forKey: .routines)
        try container.encodeIfPresent(self.postedWorkouts, forKey: .postedWorkouts)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.bio, forKey: .bio)
        try container.encodeIfPresent(self.sex, forKey: .sex)
        try container.encodeIfPresent(self.profileImagePath, forKey: .profileImagePath)
    }
}
