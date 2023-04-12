//
//  LocalizationPageViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 12/4/23.
//

import Foundation
import UIKit

final class LocalizationPageViewModel {
    private let defaults = UserDefaultsManager.shared
    private let notificationCenter = NotificationCenter.default
    
    private var languages = LocalizationOption.instantiate()
    
    public var showInfoAlert: ((String, String, String) -> Void)?
    public func numberOfRows() -> Int { languages.count }
    
    public func isCellSelected(at indexPath: IndexPath) -> Bool {
        languages[indexPath.row].isSelected
    }
    
    public func cellTitle(at indexPath: IndexPath) -> String {
        languages[indexPath.row].language
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        let selectedLanguage = languages[indexPath.row]
        guard !selectedLanguage.isSelected else { return }
        for i in 0..<languages.count {
            languages[i].isSelected = (i == indexPath.row)
        }
        
        defaults.save(value: selectedLanguage.code, for: .appLanguage)
        
        let currentLanguage = UserDefaultsManager.shared.retrieve(for: .appLanguage) as? String ?? Locale.preferredLanguages.first ?? "en"
        
        for i in 0..<languages.count {
            languages[i].isSelected = languages[i].code.hasPrefix(currentLanguage)
        }
        
        showInfoAlert?(
            "Информация ℹ️".localized(),
            "После смены языка приложение будет перезапущено.".localized(),
            selectedLanguage.code
        )
    }
    
    public func switchToLanguage(_ languageCode: String) {
        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        exit(0)
    }

    
}
