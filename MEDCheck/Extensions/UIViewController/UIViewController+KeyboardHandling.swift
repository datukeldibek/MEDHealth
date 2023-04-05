//
//  UIViewController+KeyboardHandling.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

extension UIViewController {
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
}
