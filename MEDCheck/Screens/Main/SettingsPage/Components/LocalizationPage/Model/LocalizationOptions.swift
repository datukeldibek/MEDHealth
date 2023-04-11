//
//  LocalizationOptions.swift
//  MEDCheck
//
//  Created by ibaikaa on 12/4/23.
//

import Foundation

struct LocalizationOption {
    var language: String
    var isSelected: Bool
}

extension LocalizationOption {
    static func instantiate() -> [LocalizationOption] {
        [
            .init(language: "Русский язык 🇷🇺", isSelected: true),
            .init(language: "Кыргыз тили 🇰🇬", isSelected: false)
        ]
    }
}
