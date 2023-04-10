//
//  FirebaseManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import FirebaseFirestore

final class FirebaseManager {
    //MARK: - Properties
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    
    //MARK: - Public Methods
    func createUser(
        userID: String,
        name: String,
        surname: String,
        email: String,
        password: String,
        phoneNumber: String,
        completion: @escaping (Error?) -> Void
    ) {
        let userData = [
            "name": name,
            "surname": surname,
            "email": email,
            "phoneNumber": phoneNumber
        ]
        self.db.collection("users").document(userID).setData(userData) { (error) in
            completion(error)
        }
    }
    
    
    func getUserData(
        userID: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        self.db
            .collection("users")
            .document(userID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard
                    let userData = snapshot?.data()
                else {
                    completion(.failure(FirebaseError.snapshotError))
                    return
                }
                
                let user = User(
                    name: userData["name"] as? String,
                    surname: userData["surname"] as? String,
                    email: userData["email"] as? String,
                    phoneNumber: userData["phoneNumber"] as? String
                )
                completion(.success(user))
            }
    }
    
}

struct User {
    let name: String?
    let surname: String?
    let email: String?
    let phoneNumber: String?
}

enum FirebaseError: Error {
    case snapshotError
}
