//
//  HomeModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import Foundation

// MARK: - Posted Workout Model
struct PostedWorkout: Identifiable, Codable {
    var id = UUID()
    let userEmail: String
    let time: String
    let reps: String
    let sets: String
    let exercises: [Exercise]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userEmail
        case time
        case reps
        case sets
        case exercises
    }
    
    init(userEmail: String, time: String, reps: String, sets: String, exercises: [Exercise]) {
        self.userEmail = userEmail
        self.time = time
        self.reps = reps
        self.sets = sets
        self.exercises = exercises
    }
    
}
