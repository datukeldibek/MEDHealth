//
//  AuthManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 3/4/23.
//

import FirebaseAuth

final class AuthManager {
    // MARK: - Singleton
    static let shared = AuthManager()
    private init () { }
    
    // MARK: - Private properties
    private let auth = FirebaseAuth.Auth.auth()
    private let provider = PhoneAuthProvider.provider()
    private let defaults = UserDefaultsManager.shared
    private let db = FirebaseDatabaseManager.shared
    
    // MARK: - Public properties
    public var uid: String? {
        auth.currentUser?.uid
    }
    
    // MARK: - Public methods
    
    // MARK: – Sign in method
    public func signIn(
        withEmail email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { completion($1) }
    }
    
    // MARK: – Sign up method
    public func signUp(
        withName name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        auth.createUser(
            withEmail: email,
            password: password
        ) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                completion(error)
            } else if let user = authResult?.user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = "\(name) \(surname)"
                changeRequest.commitChanges { completion($0) }
                
                db.saveUser(
                    uid: user.uid,
                    name: name,
                    surname: surname,
                    email: email,
                    password: password
                ) { completion($0) }
            }
        }
    }
    
    // MARK: – Reset password method
    public func sendPasswordReset(
        toEmail email: String,
        completion: @escaping (Error?) -> Void
    ) {
        auth.sendPasswordReset(withEmail: email) { completion($0) }
    }
    
    // MARK: – Sign out method
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try auth.signOut()
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    // MARK: – Other methods
    public func currentUser() -> FirebaseAuth.User? { auth.currentUser }
    
    public func updateUserProfilePhotoURL(
        photoURL: URL,
        completion: @escaping (Error?) -> Void
    ) {
        if let user = auth.currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.photoURL = photoURL
            changeRequest.commitChanges { completion($0) }
        }
    }
    
    public func updateUserData(
        name: String,
        surname: String,
        email: String,
        completion: @escaping (Error?) -> Void
    ) {
        if let user = auth.currentUser {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = "\(name) \(surname)"
            changeRequest.commitChanges { completion($0) }
            user.updateEmail(to: email) { completion($0) }
        }
    }
    
    public func updateUserPassword(
        newPassword: String,
        completion: @escaping (Error?) -> Void
    ) {
        if let user = auth.currentUser {
            user.updatePassword(to: newPassword) { completion($0) }
        }
    }
    
}
