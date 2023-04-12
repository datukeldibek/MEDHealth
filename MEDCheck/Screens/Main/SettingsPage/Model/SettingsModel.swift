//
//  SettingsModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import UIKit

struct SettingCell {
    var title: String
    var icon: UIImage?
    var destinationVC: UIViewController
}

extension SettingCell {
    static func instantiate() -> [SettingCell] {
        [
            SettingCell(
                title: "Аккаунт".localized(),
                icon: UIImage(systemName: "person"),
                destinationVC: ProfilePageViewController.instantiate()
            ),
            
            SettingCell(
                title: "Язык".localized(),
                icon: UIImage(systemName: "globe.americas.fill"),
                destinationVC: LocalizationSettingViewController.instantiate()
            )
        ]
    }
}
