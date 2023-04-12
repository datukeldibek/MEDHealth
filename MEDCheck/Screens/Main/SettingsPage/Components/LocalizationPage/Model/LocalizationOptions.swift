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
    var code: String
}

extension LocalizationOption {
    static func instantiate() -> [LocalizationOption] {
        let currentLanguage = UserDefaultsManager.shared.retrieve(for: .appLanguage) as? String ?? Locale.preferredLanguages.first ?? "en"
        
        let options: [LocalizationOption] = [
            
            .init(
                language: "Русский язык 🇷🇺",
                isSelected: currentLanguage.hasPrefix("ru"),
                code: "ru"
            ),
            
            .init(
                language: "Кыргыз тили 🇰🇬",
                isSelected: currentLanguage.hasPrefix("ky"),
                code: "ky"
            ),
            
            .init(
                language: "English 🇺🇸",
                isSelected: currentLanguage.hasPrefix("en"),
                code: "en"
            )
            
        ]
        
        return options
    }
}

