//
//  SettingsViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import UIKit
import Kingfisher

final class SettingsViewModel {
    // MARK: - Private properties
    private let defaults = UserDefaultsManager.shared
    private let settingsCells = SettingCell.instantiate()
    
    private let authManager = AuthManager.shared
    private let storage = FirebaseStorageManager.shared
    private let db = FirebaseDatabaseManager.shared
    
    private var uid: String {
        authManager.currentUser()?.uid ?? ""
    }
    
    // MARK: - Public properties
    public var showAlert: ((String) -> Void)?
    public var goToSignInVC: (() -> Void)?
    public var goToDestinationVC: ((UIViewController) -> Void)?
    
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
    public func setProfilePicture(to imageView: UIImageView) {
        db.getUserData(uid: uid, forKey: .profilePictureURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profilePictureURL):
                imageView.kf.setImage(
                    with: URL(string: profilePictureURL),
                    placeholder: UIImage(systemName: "person")
                )
            case .failure(let error):
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
    public func saveProfilePicture(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
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
        let destinationVC = settingsCells[indexPath.row].destinationVC
        goToDestinationVC?(destinationVC)
    }
}
