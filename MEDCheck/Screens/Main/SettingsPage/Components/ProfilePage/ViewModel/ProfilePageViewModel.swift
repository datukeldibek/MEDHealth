//
//  ProfilePageViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import Foundation

final class ProfilePageViewModel {
    // MARK: - Private properties
    private let db = FirebaseDatabaseManager.shared
    private let authManager = AuthManager.shared
    
    private var uid: String {
        authManager.uid ?? ""
    }
    
    // MARK: - Public properties
    public var showError: ((String) -> Void)?

    // MARK: - Public methods
    public func userName() -> String? {
        authManager.currentUser()?.displayName?.components(separatedBy: " ").first
    }
    
    public func userSurname() -> String? {
        authManager.currentUser()?.displayName?.components(separatedBy: " ").last
    }
    
    public func userEmail() -> String? {
        authManager.currentUser()?.email
    }
    
    public func updateValues(
        name: String,
        surname: String,
        email: String
    ) {
        authManager.updateUserData(name: name, surname: surname, email: email) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else  {
                self.showError?(error!.localizedDescription)
                return
            }
        }
        
        db.updateUserData(uid: uid, newData: name, key: .name) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else  {
                self.showError?(error!.localizedDescription)
                return
            }
        }
        
        db.updateUserData(uid: uid, newData: surname, key: .surname){ [weak self] error in
            guard let self = self else { return }
            guard error == nil else  {
                self.showError?(error!.localizedDescription)
                return
            }
        }
        
        db.updateUserData(uid: uid, newData: email, key: .email) { [weak self] error in
            guard let self = self else { return }
            guard error == nil else  {
                self.showError?(error!.localizedDescription)
                return
            }
        }
    }
    
    public func updatePassword(newPassword: String) {
        authManager.updateUserPassword(newPassword: newPassword) {  [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showError?(error.localizedDescription)
            }
        }
    }
    
}
