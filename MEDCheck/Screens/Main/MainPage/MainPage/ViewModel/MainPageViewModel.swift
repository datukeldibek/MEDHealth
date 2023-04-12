//
//  MainPageViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

final class MainPageViewModel {
    // MARK: - Private properties
    private let authManager = AuthManager.shared
    
    // MARK: - Public properties
    public let features = Feature.instantiate()
    
    // MARK: - Public methods
    public func userName() -> String? {
        authManager.currentUser()?.displayName?.components(separatedBy: " ").first
    }
    
    public func getVCForSelectedCell(
        at indexPath: IndexPath
    ) -> UIViewController {
        let feature = features[indexPath.row]
        let destinationVC = feature.destinationVC.instantiate()
        return destinationVC
    }
    
}
