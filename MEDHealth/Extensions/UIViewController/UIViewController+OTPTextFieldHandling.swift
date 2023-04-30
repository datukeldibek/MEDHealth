//
//  UIViewController+OTPTextFieldHandling.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

extension UIViewController {
    func switchOTPTextFieldsState(
        enabled: Bool,
        _ otpTextFiels: [UITextField]
    ) {
        otpTextFiels.forEach { $0.isEnabled = enabled }
    }
    
    func configureOTPTextFields(_ otpTextFields: [UITextField]) {
        otpTextFields.forEach { otpDigitTextField in
            otpDigitTextField.addTarget(
                self,
                action: #selector(textDidChange),
                for: .editingChanged
            )
        }
    }
    
    @objc
    func textDidChange(_ textField: UITextField) {
        guard
            let otpTextFields = textField
                .superview?
                .subviews
                .compactMap({ $0 as? UITextField }),
            let currentIndex = otpTextFields.firstIndex(of: textField)
        else { return }
        
        guard
            let text = textField.text,
            !text.isEmpty
        else {
            if currentIndex != 0 {
                otpTextFields[currentIndex - 1].becomeFirstResponder()
            }
            return
        }
        
        if currentIndex == otpTextFields.count - 1 {
            textField.resignFirstResponder()
        } else {
            otpTextFields[currentIndex + 1].becomeFirstResponder()
        }
    }
    
}
