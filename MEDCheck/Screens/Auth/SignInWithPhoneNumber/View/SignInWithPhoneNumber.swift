//
//  SignInWithPhoneNumberViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

final class SignInWithPhoneNumberViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = SignInWithPhoneNumberViewModel()
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showWarningAlert(title: "Ошибка", message: error)
            }
        }
        
        viewModel.goToMainVC = { [weak self] in
            DispatchQueue.main.async {
                self?.goToMainVC()
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private var otpTextFields: [UITextField]!
    @IBOutlet private weak var signInButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func getSMSCodeButtonTapped(_ sender: Any) {
        guard isPhoneNumberInput(from: phoneNumberTextField)
        else {
            showWarningAlert(
                title: "Ошибка!",
                message: "Заполни поле для ввода номера телефона корректно!"
            )
            return
        }
        
        viewModel.getSMSCode(forPhoneNumber: phoneNumberTextField.text!)

        switchOTPTextFieldsState(enabled: true, otpTextFields)
        signInButton.isEnabled = true
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        signInButton.setHapticFeedback(feedbackStyle: .medium)
        let smsCode = otpTextFields.compactMap { $0.text }.joined()
        guard smsCode.count == otpTextFields.count else {
            showWarningAlert(
                title: "Ошибка",
                message: "Неизвестная ошибка. Попробуй еще раз."
            )
            return
        }
        
        viewModel.signIn(withVerificationCode: smsCode)
    }
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        // From extension: File: UIViewController+OTPTextField.swift
        configureOTPTextFields(otpTextFields)
        // From extension. File: Extension+UIViewController.swift
        configureViewTappedHandling()
    }
}
