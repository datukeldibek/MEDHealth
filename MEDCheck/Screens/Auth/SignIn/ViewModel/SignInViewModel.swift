//
//  SignInViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import Foundation

final class SignInViewModel {
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    public var goToMainVC: (() -> Void)? 
    
    // MARK: - Public methods
    public func signIn(withEmail email: String, password: String) {
        authManager.signIn(withEmail: email, password: password) { [weak self] error in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.showAlert?(error.localizedDescription)
            } else {
                strongSelf.goToMainVC?()
            }
        }
    }
    
}
