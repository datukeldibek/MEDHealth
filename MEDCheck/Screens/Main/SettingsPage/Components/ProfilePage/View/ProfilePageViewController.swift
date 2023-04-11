//
//  ProfilePageViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import UIKit

final class ProfilePageViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = ProfilePageViewModel()
    
    private var textFields: [UITextField] {
        [
            nameTextField,
            surnameTextField,
            emailTextField,
            newPasswordTextField,
            confirmPasswordTextField
        ]
    }
    
    private var passwordTextFieldModified: Bool { newPasswordTextField.hasText && confirmPasswordTextField.hasText }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!


    // MARK: - IBActions
    @IBAction func editButtonTapped(_ sender: Any) {
        switchTextFieldsState(isEnabled: true, textFields: textFields)
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: Any) {
        checkUserDataAndPasswordTextFields()
    }
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showInfoAlert(title: "Ошибка", message: error)
            }
        }
        
        viewModel.showSuccess = { [weak self] message in
            DispatchQueue.main.async {
                self?.showInfoAlert(title: "Ошибка", message: message)
            }
        }
    }
    
    private func switchTextFieldsState(isEnabled: Bool, textFields: [UITextField]) {
        textFields.forEach { $0.isEnabled = isEnabled
            updateUIForTextFieldState(isEnabled: isEnabled, textField: $0)
        }
    }
    
    private func updateUIForTextFieldState(isEnabled: Bool, textField: UITextField) {
        textField.backgroundColor = isEnabled ? .white : .systemGray6
    }
    
    private func configureTextFieldsToolbar() {
        textFields.forEach { $0.setToolbar() }
    }
    
    private func checkUserDataAndPasswordTextFields() {
        let isValidUserData = nameTextField.hasText && surnameTextField.hasText && emailTextField.hasText
        if !isValidUserData {
            showInfoAlert(
                title: "Ошибка",
                message: "Поля не могут быть пустыми!"
            )
            return
        }
        
        if passwordTextFieldModified {
            if newPasswordTextField.text != confirmPasswordTextField.text {
                showInfoAlert(
                    title: "Ошибка",
                    message: "Пароли должны совпадать!"
                )
                return
            }
            
            viewModel.updatePassword(newPassword: newPasswordTextField.text!)
        }
        
        viewModel.updateValues(
            name: nameTextField.text!,
            surname: surnameTextField.text!,
            email: emailTextField.text!
        )
        
        showInfoAlert(title: "Успех", message: "Данные успешно изменены ✅")
    }

    private func setDataToTextFields() {
        nameTextField.text = viewModel.userName()
        surnameTextField.text = viewModel.userSurname()
        emailTextField.text = viewModel.userEmail()
    }
    
    
    // MARK: - viewDidLoad(); viewWillAppear(); viewWillDissapear()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsToolbar()
        configureViewTappedHandling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDataToTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        switchTextFieldsState(isEnabled: false, textFields: textFields)
    }
    
}
