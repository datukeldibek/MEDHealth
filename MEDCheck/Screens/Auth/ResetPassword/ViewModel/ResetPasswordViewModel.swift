//
//  ResetPasswordViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import Foundation

final class ResetPasswordViewModel {
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    public var goToSignInVC: (() -> Void)?
    
    // MARK: - Public methods
    public func reset(forEmail email: String) {
        authManager.sendPasswordReset(toEmail: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            } else {
                self.goToSignInVC?()
            }
        }
    }
    
}
