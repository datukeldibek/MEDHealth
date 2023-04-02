//
//  Extension+UITextField.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import UIKit

extension UITextField {
    @IBInspectable var toolBarOn: Bool {
        get { self.toolBarOn }
        set { setToolbar() }
    }
    
    // MARK: - setToolbar()
    func setToolbar() {
        let toolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 35
            )
        )
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.items = [
            UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            ),
            
            UIBarButtonItem(
                title: "Скрыть клавиатуру",
                style: .done,
                target: self,
                action: #selector(doneButtonTapped)
            )
        ]
        toolbar.barTintColor = #colorLiteral(red: 0.7568627451, green: 0.9137254902, blue: 1, alpha: 0.7)

        toolbar.sizeToFit()
        self.inputAccessoryView = toolbar
    }

    @objc private func doneButtonTapped() {
        self.resignFirstResponder()
    }
    
    // MARK: - left and right padding
    @IBInspectable var leftPaddingPoints: CGFloat {
        set { setLeftPaddingPoints(newValue) }
        get { self.leftPaddingPoints }
    }
    
    private func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: amount,
                height: self.frame.size.height
            )
        )
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    @IBInspectable var rightPaddingPoints: CGFloat {
        set { setRightPaddingPoints(newValue) }
        get { self.rightPaddingPoints }
    }
    
    private func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: amount,
                height: self.frame.size.height
            )
        )
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}


