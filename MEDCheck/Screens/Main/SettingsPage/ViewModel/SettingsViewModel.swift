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
    private let settingsCells = SettingCell.instantiate()
    
    private let authManager = AuthManager.shared
    private let storage = FirebaseStorageManager.shared
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    public var goToSignInVC: (() -> Void)?
    
    // MARK: - Public methods
    
    // MARK: – Sign out
    public func signOut() {
        authManager.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            } else {
                goToSignInVC?()
                defaults.delete(for: .chosenImage)
            }
        }
    }
    
    
    // MARK: – UIPreparing
    public func getProfilePicture() -> UIImage  {
        guard
            let imageData = defaults.retrieve(for: .chosenImage) as? Data
        else {
            return UIImage(systemName: "person")!
        }
        
        return UIImage(data: imageData) ?? UIImage(systemName: "person")!
    }
    
    public func savePic(image: UIImage) {
        guard
            let imageData = image.jpegData(compressionQuality: 0.4),
            let uid = authManager.currentUser()?.uid
        else {
            showAlert?("Не удалось сохранить картинку. Попробуй еще раз.")
            return
        }
        
        storage.saveProfilePictureImage(
            userID: uid,
            imageData: imageData
        ) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
    public func saveProfilePicture(image: UIImage) {
        let imageData = image.pngData()
        defaults.save(value: imageData, for: .chosenImage)
    }
    
    public func getUserDisplayName() -> String? {
        authManager.currentUser()?.displayName
    }
    
    public func getUserEmail() -> String? {
        authManager.currentUser()?.email
    }
    
    // MARK: – for UITableView
    public func numberOfRows() -> Int { settingsCells.count }
    
    public func cellTitle(at indexPath: IndexPath) -> String { settingsCells[indexPath.row].title
    }
    
    public func cellIcon(at indexPath: IndexPath) -> UIImage? {
        settingsCells[indexPath.row].icon
    }
    
    public func didSelectRow(at indexPath: IndexPath) {
        print("selected \"\(settingsCells[indexPath.row].title)\" cell.")
    }
}
