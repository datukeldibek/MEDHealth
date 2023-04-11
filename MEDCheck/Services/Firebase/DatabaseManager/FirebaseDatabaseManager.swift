//
//  FirebaseDatabaseManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import FirebaseDatabase

let REF_USER = "users"

fileprivate enum FirebaseDatabaseErrors: Error {
    case snapshotError
}

final class FirebaseDatabaseManager {
    // MARK: - Singleton
    static let shared = FirebaseDatabaseManager()
    private init () { }
    
    // MARK: - Private properties
    private let ref = Database.database().reference()
    
    // MARK: - Private methods
    private func getUserReference(for uid: String) -> DatabaseReference {
        ref.child(REF_USER).child(uid)
    }
    
    private func getUserData(
        uid: String,
        completion: @escaping (Result<[String:Any], Error>) -> Void
    ) {
        let userRef = getUserReference(for: uid)
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String:Any] else {
                completion(.failure(FirebaseDatabaseErrors.snapshotError))
                return
            }
            
            completion(.success(userData))
        }
    }
    
    // MARK: - Public methods
    public func saveUser(
        uid: String,
        phoneNumber: String,
        completion: @escaping ((Error?) -> Void)
    ) {
        let userData: [String:Any] = [
            UserDataKeys.uid.rawValue: uid,
            UserDataKeys.name.rawValue: "",
            UserDataKeys.surname.rawValue: "",
            UserDataKeys.email.rawValue: "",
            UserDataKeys.password.rawValue: "",
            UserDataKeys.profilePictureURL.rawValue: "",
            UserDataKeys.phoneNumber.rawValue: phoneNumber
        ]
        
        let userRef = getUserReference(for: uid)
        
        userRef.updateChildValues(userData) { error, _ in
            completion(error)
        }
    }
    
    public func saveUser(
        uid: String,
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping ((Error?) -> Void)
    ) {
        let userData: [String:Any] = [
            UserDataKeys.uid.rawValue: uid,
            UserDataKeys.name.rawValue: name,
            UserDataKeys.surname.rawValue: surname,
            UserDataKeys.email.rawValue: email,
            UserDataKeys.password.rawValue: password,
            UserDataKeys.profilePictureURL.rawValue: "",
            UserDataKeys.phoneNumber.rawValue: ""
        ]
        
        let userRef = getUserReference(for: uid)
        
        userRef.updateChildValues(userData) { error, _ in
            completion(error)
        }
    }
    
    public func getUserData(
        uid: String,
        forKey key: UserDataKeys,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        let userRef = getUserReference(for: uid)
        userRef.observeSingleEvent(of: .value) { snapshot, _ in
            guard let userData = snapshot.value as? [String:Any] else {
                completion(.failure(FirebaseDatabaseErrors.snapshotError))
                return
            }
            
            completion(
                .success(
                    userData[key.rawValue] as? String ?? ""
                )
            )
        }
    }
    
    public func updateUserData(
        uid: String,
        newData: String,
        key: UserDataKeys,
        completion: @escaping ((Error?) -> Void)
    ) {
        self.getUserData(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(var userData):
                userData[key.rawValue] = newData
                
                let userRef = self.getUserReference(for: uid)
                userRef.updateChildValues(userData) { error, _ in
                    completion(error)
                }
                
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    public func updateUserData(
        uid: String,
        newData: [String: Any],
        completion: @escaping ((Error?) -> Void)
    ) {
        let userRef = self.getUserReference(for: uid)
        userRef.updateChildValues(newData) { error, _ in
            completion(error)
        }
    }
    
}


