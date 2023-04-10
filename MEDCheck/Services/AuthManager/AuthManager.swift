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
    
    // MARK: - Public methods
    
    // MARK: – Sign in methods
    public func signIn(
        withEmail email: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
    
    public func getSMSCode(
        forPhoneNumber phoneNumber: String,
        completion: @escaping (Error?) -> Void
    ) {
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                completion(error)
            } else {
                self?.defaults.save(value: verificationID, for: .authVerification)
                completion(nil)
            }
        }
    }
    
    public func signIn(
        withVerificationCode verificationCode: String,
        completion: @escaping (Error?) -> Void
    ) {
        guard let verificationID = defaults.retrieve(for: .authVerification) as? String else {
            completion(
                NSError(
                    domain: "",
                    code: 0,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Verification ID not found"
                    ]
                )
            )
            return
        }
        
        let credential = provider.credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        auth.signIn(with: credential) { authResult, error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
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
                changeRequest.commitChanges { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
                
                db.saveUser(
                    uid: user.uid,
                    name: name,
                    surname: surname,
                    email: email,
                    password: password
                ) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
    }
    
    // MARK: – Sign out method
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try auth.signOut()
            completion(nil)
        } catch {
            print(error.localizedDescription)
            completion(error)
        }
    }
    
    // MARK: – Other methods
    public func currentUser() -> FirebaseAuth.User? { auth.currentUser }
    
}
