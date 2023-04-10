//
//  MainTabBarController.swift
//  MEDCheck
//
//  Created by ibaikaa on 2/4/23.
//

import UIKit

final class MainTabBarController: UITabBarController {
    private func initUI() {
        tabBar.barTintColor = #colorLiteral(red: 0.7568627451, green: 0.9137254902, blue: 1, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        observeNetworkStatusUpdates()
    }
}
