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
            phoneNumberTextField,
            newPasswordTextField,
            confirmPasswordTextField
        ]
        
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!


    // MARK: - IBActions
    @IBAction func editButtonTapped(_ sender: Any) {
        switchTextFieldsState(isEnabled: true, textFields: textFields)
    }
    
    @IBAction func saveChangesButtonTapped(_ sender: Any) {
        print("save")
        switchTextFieldsState(isEnabled: false, textFields: textFields)
    }
    
    // MARK: - Private methods
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
    
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsToolbar()
        
        configureViewTappedHandling()
    }
}
