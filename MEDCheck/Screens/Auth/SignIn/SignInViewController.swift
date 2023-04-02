//
//  SignInViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 27/3/23.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - Private properties
    private var textFields: [UITextField] {
        [emailTextField, passwordTextField]
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
            print("Переходим дальше")
        } else {
            showWarningAlert(
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
        // From extension. File: Extension+UIViewController.swift
        configureViewTappedHandling()
        configureKeyboardHandling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // From extension. File: UIViewController+NetworkStatusAware.swift
        observeNetworkStatusUpdates()
    }
}

