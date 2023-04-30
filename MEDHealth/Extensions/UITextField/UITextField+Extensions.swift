//
//  Extension+UITextField.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import UIKit

extension UITextField {
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


