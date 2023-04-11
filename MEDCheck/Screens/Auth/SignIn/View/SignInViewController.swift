//
//  SignInViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 27/3/23.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = SignInViewModel()
    private var textFields: [UITextField] {
        [emailTextField, passwordTextField]
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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showOrHidePWDButton: UIButton!
    @IBOutlet weak var signInWithCodeButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - IBActions
    private var isHidden: Bool = true
    @IBAction func showOrHidePassword(_ sender: Any) {
        if isHidden {
            // show password text
            passwordTextField.isSecureTextEntry = false
            showOrHidePWDButton.setImage(
                UIImage(systemName: "eye.slash"),
                for: .normal
            )
        } else {
            // hide password text
            passwordTextField.isSecureTextEntry = true
            showOrHidePWDButton.setImage(
                UIImage(systemName: "eye"),
                for: .normal
            )
        }
        
        isHidden.toggle()
    }
    
    @IBAction func signInWithCodeButtonTapped(_ sender: Any) {
        signInWithCodeButton.setHapticFeedback(feedbackStyle: .medium)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        signInButton.setHapticFeedback(feedbackStyle: .medium)
        updateUIForTextFields(textFields)
        
        if textFields.allSatisfy( {$0.hasText} ) {
            viewModel.signIn(
                withEmail: emailTextField.text!,
                password: passwordTextField.text!
            )
        } else {
            showInfoAlert(
                title: "Ошибка!",
                message: "Пожалуйста, заполни все поля."
            )
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        registerButton.setHapticFeedback(feedbackStyle: .medium)
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        configureViewTappedHandling()
        configureKeyboardHandling()
        observeNetworkStatusUpdates()
    }
    
}

