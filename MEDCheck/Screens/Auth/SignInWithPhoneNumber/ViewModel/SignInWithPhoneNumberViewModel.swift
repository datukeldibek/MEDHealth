//
//  SignInWithPhoneNumberViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import Foundation

final class SignInWithPhoneNumberViewModel {
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    public var goToMainVC: (() -> Void)?
    
    // MARK: - Public methods
    public func getSMSCode(forPhoneNumber phoneNumber: String) {
        authManager.getSMSCode(forPhoneNumber: phoneNumber) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
    public func signIn(withVerificationCode verificationCode: String) {
        authManager.signIn(withVerificationCode: verificationCode) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            } else {
                self.goToMainVC?()
            }
        }
    }

}
