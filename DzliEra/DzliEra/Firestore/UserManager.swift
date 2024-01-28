//
//  UserManager.swift
//  DzliEra
//
//  Created by Levan Loladze on 28.01.24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
    func createNewUser(auth: AuthDataResultModel) {
        var userData: [String:Any] = [
            "user_id" : auth.uid,
            "date_created" : Timestamp()
        ]
        
        if let email = auth.email {
            userData["email"] = email
        }
        
        Firestore.firestore().collection("users").document(userId).setData(<#T##documentData: [String : Any]##[String : Any]#>, mergeFields: <#T##[Any]#>)
    }
    
}
