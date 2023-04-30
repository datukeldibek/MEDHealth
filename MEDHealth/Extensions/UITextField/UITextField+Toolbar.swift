//
//  UITextField+Toolbar.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

extension UITextField {
    @IBInspectable var toolBarOn: Bool {
        get { self.toolBarOn }
        set { setToolbar() }
    }
    
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
                title: "Скрыть клавиатуру".localized(),
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
    
}
