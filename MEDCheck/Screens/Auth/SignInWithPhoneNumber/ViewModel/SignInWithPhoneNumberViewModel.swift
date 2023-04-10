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
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.showAlert?(error.localizedDescription)
            } else {
                print("Успешно отправлена смска по номеру телефона \(phoneNumber).")
            }
        }
    }
    
    public func signIn(withVerificationCode verificationCode: String) {
        authManager.signIn(withVerificationCode: verificationCode) { [weak self] error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.showAlert?(error.localizedDescription)
            } else {
                strongSelf.goToMainVC?()
            }
            
        }
    }

}
