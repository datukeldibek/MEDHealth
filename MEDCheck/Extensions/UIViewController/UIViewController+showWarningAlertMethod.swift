//
//  UIViewController+showWarningAlertMethod.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

extension UIViewController {
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

}
