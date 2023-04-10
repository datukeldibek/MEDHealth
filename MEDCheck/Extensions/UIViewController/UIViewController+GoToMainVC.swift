//
//  UIViewController+GoToMainVC.swift
//  MEDCheck
//
//  Created by ibaikaa on 10/4/23.
//

import UIKit

extension UIViewController {
    func goToMainVC() {
        let mainVC = MainTabBarController.instantiate()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .flipHorizontal
        present(mainVC, animated: true)
    }
}
