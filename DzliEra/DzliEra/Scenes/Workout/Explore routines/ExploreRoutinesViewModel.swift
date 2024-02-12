//
//  ExploreRoutinesViewModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 12.02.24.
//

import Foundation

// MARK: - ExploreRoutinesViewModel
final class ExploreRoutinesViewModel {
    // MARK: - properties
    var fetchingStatus: FetchingStatus = .idle
    var user: DBUser?
    var onDataUpdate: (() -> Void)?
    var routines: [Routine] = []
    
    let games = [
        PlaceHolderModel("Pacman", "1980"),
        PlaceHolderModel("Space Invaders", "1978"),
        PlaceHolderModel("Frogger", "1981"),
        PlaceHolderModel("Pacman", "1980"),
        PlaceHolderModel("Space Invaders", "1978"),
        PlaceHolderModel("Frogger", "1981"),
        PlaceHolderModel("Pacman", "1980"),
        PlaceHolderModel("Space Invaders", "1978"),
        PlaceHolderModel("Frogger", "1981")
    ]
    
    // MARK: - Methods
    func fetchAllRoutines() {
        self.fetchingStatus = .fetching
        
        Task {
            do {
                
                let routines = try await UserManager.shared.getAllRoutinesFromCollection()
                self.routines = routines
                
                print(routines)
                if routines.isEmpty {
                    self.fetchingStatus = .idle
                } else {
                    self.fetchingStatus = .success
                }
                DispatchQueue.main.async {
                    self.onDataUpdate?()
                }
                
            } catch {
                print("Error loading user: \(error)")
                
                self.fetchingStatus = .failure
                
            }
        }
    }
    
}
