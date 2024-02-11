//
//  NutritionViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 11.02.24.
//

import Foundation
import NetworkingPackageRapid

final class NutritionViewModel {
    
    
    
    func fetchNutritionData(for query: String) {
        let urlString = "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=\(query)"
        
        let headers = [
                "X-RapidAPI-Key": "e25ec639d7mshd940771000c24d6p1f2c8ejsn3c254eb3fe8a",
                "X-RapidAPI-Host": "nutrition-by-api-ninjas.p.rapidapi.com"
            ]
        
        NetworkManagerRapid.fetchData(from: urlString, headers: headers, modelType: Exercises.self) { result in
                switch result {
                case .success(let exercises):
                    self.exercises = exercises
                    DispatchQueue.main.async {
                        self.delegate?.exerciseListViewModelDidFetchData(self)
                    }
                case .failure(let error):
                    // Handle error
                    print("Error: \(error)")
                }
            }
    }
}
