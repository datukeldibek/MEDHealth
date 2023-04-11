//
//  LocalizationPageViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 12/4/23.
//

import Foundation

final class LocalizationPageViewModel {
    private let defaults = UserDefaultsManager.shared
    private var languages = LocalizationOption.instantiate()
    
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
    }
    
}
