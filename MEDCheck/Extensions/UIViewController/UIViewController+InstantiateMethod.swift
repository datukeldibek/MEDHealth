//
//  Extension+UIViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 29/3/23.
//

import UIKit

extension UIViewController {
    static func instantiate(storyboardName: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let identifier = String(describing: Self.self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? Self ?? Self()
    }
        
}
