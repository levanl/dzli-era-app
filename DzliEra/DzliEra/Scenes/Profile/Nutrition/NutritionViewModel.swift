//
//  NutritionViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 11.02.24.
//

import Foundation
import NetworkingPackageRapid

final class NutritionViewModel {
    
    var nutritionData: [NutritionModel] = []
    var imageData: [NutritionImageResult] = []
    
    
    func fetchNutritionData(for query: String, completion: @escaping ([NutritionModel]?) -> Void) {
        let urlString = "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=\(query)"
        
        let headers = [
            "X-RapidAPI-Key": "e25ec639d7mshd940771000c24d6p1f2c8ejsn3c254eb3fe8a",
            "X-RapidAPI-Host": "nutrition-by-api-ninjas.p.rapidapi.com"
        ]
        
        NetworkManagerRapid.fetchData(from: urlString, headers: headers, modelType: [NutritionModel].self) { result in
            switch result {
            case .success(let nutrition):
                self.nutritionData = nutrition
                completion(nutrition)
            case .failure(let error):
                
                print("Error: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchImageData(for query: String) {
        
        let urlString = "https://free-images-api.p.rapidapi.com/images/\(query)"
        
        let headers = [
            "X-RapidAPI-Key": "e25ec639d7mshd940771000c24d6p1f2c8ejsn3c254eb3fe8a",
            "X-RapidAPI-Host": "free-images-api.p.rapidapi.com"
        ]
        
        NetworkManagerRapid.fetchData(from: urlString, headers: headers, modelType: NutritionImageModel.self) { result in
            switch result {
            case .success(let imageData):
                self.imageData = imageData.results
                
                print(imageData)
            case .failure(let error):
                print("Error fetching image data: \(error)")
                
            }
        }
    }
}
