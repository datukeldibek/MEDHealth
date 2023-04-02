//
//  SignUpSecondViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

final class SignUpSecondViewController: UIViewController {
    // MARK: - Private properties
    
    // MARK: - Private methods
    
    // MARK: - IBOutlets
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private var otpTextFields: [UITextField]!
    @IBOutlet private weak var signUpButton: UIButton!
    
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
        
        switchOTPTextFieldsState(enabled: true, otpTextFields)
//         viewModel.getSmsCode()
        signUpButton.isEnabled = true
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        signUpButton.setHapticFeedback(feedbackStyle: .medium)
    }
        
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // From extension: File: UIViewController+OTPTextField.swift
        configureOTPTextFields(otpTextFields)
        // From extension. File: Extension+UIViewController.swift
        configureViewTappedHandling()
    }
}
