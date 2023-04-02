//
//  SignUpFirstViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

final class SignUpFirstViewController: UIViewController {
    // MARK: - Private properties
    private var textFields: [UITextField] {
        [
            nameTextField,
            surnameTextField,
            mailTextField,
            passwordTextField
        ]
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
            let vc = SignUpSecondViewController.instantiate()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showWarningAlert(
                title: "Ошибка!",
                message: "Пожалуйста, заполни все поля."
            )
        }
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // From extension. File: Extension+UIViewController.swift
        configureViewTappedHandling()
    }
}
