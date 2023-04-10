//
//  FirebaseDatabaseManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import FirebaseDatabase

final class FirebaseDatabaseManager {
    static let shared = FirebaseDatabaseManager()
    private init () { }
    
    private var ref: DatabaseReference = Database.database().reference()
    
    public func saveUser(
        uid: String,
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping ((Error?) -> Void)
    ) {
        let userData: [String:String] = [
            "uid": uid,
            "name": name,
            "surname": surname,
            "email": email,
            "password": password
        ]
        
        ref.child("users").child(uid).updateChildValues(userData) { error, _ in
            if error == nil { print("Done") } else { completion(error) }
        }
        
        
        
        
        

    }
    
    
}
