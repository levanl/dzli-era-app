//
//  ExerciseListViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 21.01.24.
//

import Foundation
import NetworkingPackageRapid

// MARK: - ExerciseListViewModelDelegate
protocol ExerciseListViewModelDelegate: AnyObject {
    func exerciseListViewModelDidFetchData(_ viewModel: ExerciseListViewModel)
}

// MARK: - ViewModel
final class ExerciseListViewModel {
    
    // MARK: - Properties
    var exercises: [Exercise] = []
    weak var delegate: ExerciseListViewModelDelegate?
    
    var numberOfExercises: Int {
        exercises.count
    }
    
    func exerciseName(at index: Int) -> String {
        return "Exercise \(index + 1)"
    }
    
    // MARK: - Init
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
        
        let headers = [
            "X-RapidAPI-Key": "e25ec639d7mshd940771000c24d6p1f2c8ejsn3c254eb3fe8a",
            "X-RapidAPI-Host": "exercisedb.p.rapidapi.com"
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
