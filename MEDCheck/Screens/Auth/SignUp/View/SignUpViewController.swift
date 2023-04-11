//
//  SignUpViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

final class SignUpViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = SignUpViewModel()
    
    private var textFields: [UITextField] {
        [
            nameTextField,
            surnameTextField,
            mailTextField,
            passwordTextField
        ]
    }
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showInfoAlert(title: "Ошибка", message: error)
            }
        }
        
        viewModel.goToMainVC = { [weak self] in
            DispatchQueue.main.async {
                self?.goToMainVC()
            }
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func nextButtonTapped(_ sender: Any) {
        nextButton.setHapticFeedback(feedbackStyle: .medium)
        updateUIForTextFields(textFields)
        
        if textFields.allSatisfy({ $0.hasText }) {
            viewModel.signUp(
                name: nameTextField.text!,
                surname: surnameTextField.text!,
                email: mailTextField.text!,
                password: passwordTextField.text!
            )
        } else {
            showInfoAlert(
                title: "Ошибка!",
                message: "Пожалуйста, заполни все поля."
            )
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureViewTappedHandling()
    }
    
}
