//
//  HomeModel.swift
//  DzliEra
//
//  Created by Levan Loladze on 03.02.24.
//

import Foundation

struct PostedWorkout: Identifiable {
    let id = UUID()
    let userEmail: String
    let time: String
    let reps: String
    let sets: String
    
    
}
