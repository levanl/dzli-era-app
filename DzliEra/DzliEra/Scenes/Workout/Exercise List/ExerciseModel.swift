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
    let secondaryMuscles, instructions: [String]?
    
    enum CodingKeys: String, CodingKey {
        case bodyPart, equipment
        case gifURL = "gifUrl"
        case id, name, target, secondaryMuscles, instructions
    }
    
    
    init(name: String, bodyPart: String, equipment: Equipment, gifURL: String, id: String, target: String, secondaryMuscles: [String]? = nil, instructions: [String]? = nil) {
            self.name = name
            self.bodyPart = bodyPart
            self.equipment = equipment
            self.gifURL = gifURL
            self.id = id
            self.target = target
            self.secondaryMuscles = secondaryMuscles ?? []
            self.instructions = instructions ?? []
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.bodyPart = try container.decodeIfPresent(String.self, forKey: .bodyPart) ?? ""
        self.equipment = try container.decodeIfPresent(Equipment.self, forKey: .equipment) ?? .bodyWeight
        self.gifURL = try container.decodeIfPresent(String.self, forKey: .gifURL) ?? ""
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.target = try container.decodeIfPresent(String.self, forKey: .target) ?? ""
        self.secondaryMuscles = try container.decodeIfPresent([String].self, forKey: .secondaryMuscles) ?? []
        self.instructions = try container.decodeIfPresent([String].self, forKey: .instructions) ?? []
    }
}

enum Equipment: String, Codable {
    case bodyWeight = "body weight"
    case cable = "cable"
}

typealias Exercises = [Exercise]
