//
//  Extension+UIButton.swift
//  MEDCheck
//
//  Created by ibaikaa on 29/3/23.
//

import UIKit

extension UIButton {
    @IBInspectable var horizontalAlignment: Int {
        get { 0 }
        set {
            switch newValue {
            case 0: self.contentHorizontalAlignment = .left
            case 1: self.contentHorizontalAlignment = .center
            case 2: self.contentHorizontalAlignment = .right
            default: ()
            }
        }
    }
}
