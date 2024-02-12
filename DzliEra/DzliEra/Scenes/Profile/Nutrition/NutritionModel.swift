//
//  NutritionModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 11.02.24.
//

import Foundation

// MARK: - NutritionModel
struct NutritionModel: Codable {
    let name: String
    let calories, servingSizeG, fatTotalG, fatSaturatedG: Double
    let proteinG: Double
    let sodiumMg, potassiumMg, cholesterolMg: Int
    let carbohydratesTotalG, fiberG, sugarG: Double

    enum CodingKeys: String, CodingKey {
        case name, calories
        case servingSizeG = "serving_size_g"
        case fatTotalG = "fat_total_g"
        case fatSaturatedG = "fat_saturated_g"
        case proteinG = "protein_g"
        case sodiumMg = "sodium_mg"
        case potassiumMg = "potassium_mg"
        case cholesterolMg = "cholesterol_mg"
        case carbohydratesTotalG = "carbohydrates_total_g"
        case fiberG = "fiber_g"
        case sugarG = "sugar_g"
    }
}

struct NutritionImageModel: Codable {
    let results: [NutritionImageResult]
}

// MARK: - Result
struct NutritionImageResult: Codable {
    let image, by: String
    let download: String?
    let source: String
    let diffrentSizes: [String]
    let id: String
}

typealias nutritionItem = [NutritionModel]
