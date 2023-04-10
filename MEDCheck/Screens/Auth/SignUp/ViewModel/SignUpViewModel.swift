//
//  SignUpViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import Foundation

final class SignUpViewModel {
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    public var goToMainVC: (() -> Void)?
    
    // MARK: - Public methods
    public func signUp(
        name: String,
        surname: String,
        email: String,
        password: String
    ) {
        authManager.signUp(
            withName: name,
            surname: surname,
            email: email,
            password: password
        ) { [weak self] error in
            print("completion of signing up")
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            } else {
                goToMainVC?()
            }
        }
    }
    
}
