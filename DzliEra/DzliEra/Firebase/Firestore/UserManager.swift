//
//  UserManager.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.01.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

// MARK: - User Manager
final class UserManager {
    
    // MARK: - Singleton Reference
    static let shared = UserManager()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Collection References
    private let userCollection = Firestore.firestore().collection("users")
    private let postedWorkoutsCollection = Firestore.firestore().collection("posted_workouts")
    private let routinesCollection = Firestore.firestore().collection("routines")
    
    // MARK: - User Document
    private func userDocument(userId: String) -> DocumentReference {
        userCollection.document(userId)
    }
    
    // MARK: - Posted Workout Document
    private func postedWorkoutDocument(userId: String) -> DocumentReference {
        postedWorkoutsCollection.document(userId)
    }
    
    // MARK: - Routines Document
    private func routinesDocument(userId: String) -> DocumentReference {
        routinesCollection.document(userId)
    }
    
    // MARK: - Create New User Firestore
    func createNewUser(user: DBUser) async throws {
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    // MARK: - Get User From Firestore
    func getUser(userId: String) async throws -> DBUser {
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    // MARK: - Upload Routines Firestore
    func uploadRoutines(userId: String, routines: [Routine]) async throws {
        var routinesData: [[String: Any]] = []
        
        for routine in routines {
            let routineData: [String: Any] = [
                "title": routine.title,
                "exercises": try routine.exercises.map { try $0.toFirestoreData() }
            ]
            routinesData.append(routineData)
        }
        
        let data: [String: Any] = ["routines": routinesData]
        
        try await userDocument(userId: userId).setData(data, merge: true)
    }
    
    // MARK: - Upload Routines Collection
    func uploadRoutinesToCollection(routines: [Routine]) async throws {
        let batch = Firestore.firestore().batch()
        
        for routine in routines {
            let routineData: [String: Any] = [
                "title": routine.title,
                "exercises": try routine.exercises.map { try $0.toFirestoreData() }
            ]
            
            let routinesDocRef = routinesCollection.document()
            batch.setData(routineData, forDocument: routinesDocRef)
        }
        
        try await batch.commit()
    }
    
    // MARK: - Get Routines From Collection
    func getAllRoutinesFromCollection() async throws -> [Routine] {
        var routines: [Routine] = []
        
        let querySnapshot = try await Firestore.firestore().collection("routines").getDocuments()
        
        for document in querySnapshot.documents {
            let data = document.data()
            if let title = data["title"] as? String,
               let exercisesData = data["exercises"] as? [[String: Any]] {
                var exercises: [Exercise] = []
                for exerciseData in exercisesData {
                    do {
                        let exerciseJSONData = try JSONSerialization.data(withJSONObject: exerciseData, options: [])
                        let exercise = try JSONDecoder().decode(Exercise.self, from: exerciseJSONData)
                        exercises.append(exercise)
                    } catch {
                        print("Error decoding exercise data: \(error)")
                    }
                }
                let routine = Routine(title: title, exercises: exercises)
                routines.append(routine)
            }
            
        }
        
        return routines
    }
    
    // MARK: - Get Routines for User
    func getRoutines(userId: String) async throws -> [Routine] {
        let document = userDocument(userId: userId)
        let documentSnapshot = try await document.getDocument()
        
        guard let data = try? documentSnapshot.data(as: DBUser.self) else {
            throw NSError(domain: "YourErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode user data."])
        }
        
        return data.routines ?? []
    }
    
    // MARK: - Upload Posted Workout
    func uploadPostedWorkout(userId: String, postedWorkouts: [PostedWorkout]) async throws {
        var postedWorkoutsData: [[String: Any]] = []
        
        for workout in postedWorkouts {
            let workoutData: [String: Any] = [
                "userEmail": workout.userEmail,
                "time": workout.time,
                "reps": workout.reps,
                "sets": workout.sets,
                "exercises": try workout.exercises.map { try $0.toFirestoreData() }
            ]
            
            postedWorkoutsData.append(workoutData)
        }
        
        let userDocRef = userDocument(userId: userId)
        for workoutData in postedWorkoutsData {
            try await userDocRef.updateData([
                "postedWorkouts": FieldValue.arrayUnion([workoutData])
            ])
        }
    }
    
    // MARK: - Upload Posted Workout to Collection
    func savePostedWorkoutsToCollection(postedWorkouts: [PostedWorkout]) async throws {
        let batch = Firestore.firestore().batch()
        
        for workout in postedWorkouts {
            let workoutData: [String: Any] = [
                
                "userEmail": workout.userEmail,
                "time": workout.time,
                "reps": workout.reps,
                "sets": workout.sets,
                "exercises": try workout.exercises.map { try $0.toFirestoreData() }
            ]
            
            let workoutDocRef = postedWorkoutsCollection.document()
            batch.setData(workoutData, forDocument: workoutDocRef)
        }
        
        try await batch.commit()
    }
    
    // MARK: - Update User Profile
    func updateUserProfile(userId: String, name: String, bio: String, sex: String, image: UIImage?) async throws {
        
        
        let storageRef = Storage.storage().reference().child("profile_images").child(userId)
        
        Task {
            do {
                let url = try await storageRef.downloadURL()
                let imageUrl = url.absoluteString
                
                let userData: [String: Any] = [
                    "name": name,
                    "bio": bio,
                    "sex": sex,
                    "photoUrl": imageUrl
                ]
                
                try await userDocument(userId: userId).setData(userData, merge: true)
            } catch {
                print("Error uploading image or getting download URL: \(error.localizedDescription)")
            }
        }
        
    }
    
    // MARK: - UpdateUserProfileImage
    func updateUserProfileImage(userId: String, path: String) async throws {
        let data: [String: Any] = [
            DBUser.CodingKeys.profileImagePath.rawValue : path,
        ]
        try await userDocument(userId: userId).updateData(data)
    }
    
}

extension Exercise {
    func toFirestoreData() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(self)
        let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        return dictionary ?? [:]
    }
}
