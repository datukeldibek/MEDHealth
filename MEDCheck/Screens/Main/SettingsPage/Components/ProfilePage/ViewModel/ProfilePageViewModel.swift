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
        authManager.currentUser()?.uid ?? ""
    }
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    private var linkedPhoneNumber: Bool? {
        authManager.currentUser()?.phoneNumber != nil
    }
    
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
    
    public func userPhoneNumber() -> String? {
        authManager.currentUser()?.phoneNumber
    }
    
    public func linkPhoneNumber(phoneNumber: String) {
        
    }
    
    
    public func getSMSCode(for phoneNumber: String) {
        authManager.getSMSCode(forPhoneNumber: phoneNumber) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
    public func confirmChanges(
        name: String,
        surname: String,
        email: String,
        password: String,
        phoneNumber: String
    ) {
        var updatedData = [String: Any]()
        updatedData[UserDataKeys.name.rawValue] = name
        updatedData[UserDataKeys.surname.rawValue] = surname
        updatedData[UserDataKeys.email.rawValue] = email
        updatedData[UserDataKeys.password.rawValue] = password
        updatedData[UserDataKeys.phoneNumber.rawValue] = phoneNumber
        
        db.updateUserData(uid: uid, newData: updatedData) { [weak self]  error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            }
        }
        
        authManager.updateUserData(
            name: name,
            surname: surname,
            email: email,
            password: password,
            phoneNumber: phoneNumber
        ) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
}
