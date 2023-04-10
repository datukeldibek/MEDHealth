//
//  SettingsViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import UIKit

final class SettingsViewModel {
    // MARK: - Private properties
    private let defaults = UserDefaultsManager.shared
    
    // MARK: - Public methods
    public func getProfilePicture() -> UIImage?  {
        guard let imageData = defaults.retrieve(for: .chosenImage) as? Data
        else { return nil }
        return UIImage(data: imageData)
    }
    
    public func saveProfilePicture(image: UIImage) {
        let imageData = image.pngData()
        defaults.save(value: imageData, for: .chosenImage)
    }
    
}
