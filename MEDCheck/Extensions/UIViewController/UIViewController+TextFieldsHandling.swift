//
//  UIViewController+TextFieldsHandling.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

extension UIViewController {
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
    
    func isPhoneNumberInput(from textField: UITextField) -> Bool{
        guard
            let text = textField.text,
            text.prefix(4) == "+996",
            Int(text) != nil
        else { return false }
        return true
    }
    
}
