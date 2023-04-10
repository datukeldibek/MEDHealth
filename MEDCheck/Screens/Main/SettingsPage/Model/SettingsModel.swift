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
}

extension SettingCell {
    static func instantiate() -> [SettingCell] {
        [
            SettingCell(
                title: "Аккаунт",
                icon: UIImage(systemName: "person")
            ),
            
            SettingCell(
                title: "Язык",
                icon: UIImage(systemName: "globe.americas.fill")
            )
        ]
    }
}
