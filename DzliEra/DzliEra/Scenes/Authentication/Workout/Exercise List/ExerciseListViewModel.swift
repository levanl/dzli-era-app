//
//  ExerciseListViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import Foundation
import NetworkingPackageGeneric

protocol ExerciseListViewModelDelegate: AnyObject {
    func exerciseListViewModelDidFetchData(_ viewModel: ExerciseListViewModel)
}

class ExerciseListViewModel {
    
    var exercises: [Exercise] = []
    
    weak var delegate: ExerciseListViewModelDelegate?
    
    var numberOfExercises: Int {
        exercises.count
    }
    
    func exerciseName(at index: Int) -> String {
        return "Exercise \(index + 1)"
    }
    
    init() {
        fetchWorkoutData()
    }
    
    func fetchWorkoutData() {
        
        let urlString = "https://exercisedb.p.rapidapi.com/exercises?limit=10"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("error getting url")
            return
        }
        
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        let headers = [
            "X-RapidAPI-Key": "e25ec639d7mshd940771000c24d6p1f2c8ejsn3c254eb3fe8a",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
        ]
        
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    self.exercises = try decoder.decode(Exercises.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.delegate?.exerciseListViewModelDidFetchData(self)
                    }
                    
                    print("Fetched exercises: \(self.exercises)")
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        dataTask.resume()
    }
}
