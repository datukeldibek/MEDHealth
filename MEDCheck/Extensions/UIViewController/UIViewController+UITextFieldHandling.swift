//
//  UIViewController+OTPTextField.swift
//  MEDCheck
//
//  Created by ibaikaa on 3/4/23.
//

import UIKit

extension UIViewController {
  
    
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
