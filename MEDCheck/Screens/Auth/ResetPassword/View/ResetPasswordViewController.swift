//
//  ResetPasswordViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

final class ResetPasswordViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = ResetPasswordViewModel()
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = { [weak self] error in
            DispatchQueue.main.async {
                self?.showInfoAlert(title: "Ошибка", message: error)
            }
        }
        
        viewModel.goToSignInVC = { [weak self] in
            DispatchQueue.main.async {
                self?.goToSignInVC()
            }
        }
    }
    
    private func goToSignInVC() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var signInButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func signInButtonTapped(_ sender: Any) {
        signInButton.setHapticFeedback(feedbackStyle: .medium)
        viewModel.reset(forEmail: emailTextField.text!)
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureViewTappedHandling()
    }
    
}
