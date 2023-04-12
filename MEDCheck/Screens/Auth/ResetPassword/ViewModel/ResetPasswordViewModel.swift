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
    public var showInfoAlert: ((String, String) -> Void)?
    
    // MARK: - Public methods
    public func reset(forEmail email: String) {
        authManager.sendPasswordReset(toEmail: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showInfoAlert?(
                    "Ошибка ⚠️".localized(),
                    error.localizedDescription
                )
            } else {
                self.showInfoAlert?(
                    "Информация ℹ️".localized(),
                    "На почту пришло сообщение для восстановления пароля. Следуйте инструкции, чтоб восстановить пароль.".localized()
                )
            }
        }
    }
    
}
