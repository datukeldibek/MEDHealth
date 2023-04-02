//
//  Extension+UIViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 29/3/23.
//

import UIKit

extension UIViewController {
    // MARK: - Instantiate method
    static func instantiate(storyboardName: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = String(describing: Self.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
        
    // MARK: - Configuring keyboard handling
    func configureKeyboardHandling() {
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        
        NotificationCenter.default
            .addObserver(
                self,
                selector: #selector(keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
            )
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: - Configuring view tapping
    func configureViewTappedHandling() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    @objc
    private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - showWarningAlert()
    func showWarningAlert (
        title: String,
        message: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "OK", style: .cancel)
        )
        present(alert, animated: true)
    }
    
    // MARK: - updateUIForTextFields()
    func updateUIForTextFields(_ textFields: [UITextField]) {
        textFields.forEach { textField in
            if textField.hasText {
                textField.layer.borderWidth = 0
            } else {
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    // MARK: - checkPhoneNumberInput(text: String)
    func isPhoneNumberInput(from textField: UITextField) -> Bool{
        guard
            let text = textField.text,
            text.prefix(4) == "+996",
            Int(text) != nil
        else { return false }
        return true 
    }


}
