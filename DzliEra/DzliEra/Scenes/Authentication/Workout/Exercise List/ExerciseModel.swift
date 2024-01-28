//
//  ExerciseModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import Foundation

struct Exercise: Codable {
    let bodyPart: String
    let equipment: Equipment
    let gifURL: String
    let id, name, target: String
    let secondaryMuscles, instructions: [String]

    enum CodingKeys: String, CodingKey {
        case bodyPart, equipment
        case gifURL = "gifUrl"
        case id, name, target, secondaryMuscles, instructions
    }
}

enum Equipment: String, Codable {
    case bodyWeight = "body weight"
    case cable = "cable"
}

typealias Exercises = [Exercise]
