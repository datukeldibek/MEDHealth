//
//  MainPageViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

final class MainPageViewModel {
    // MARK: - Private properties
    private var defaults = UserDefaultsManager.shared
    
    // MARK: - Public properties
    public let features = Feature.instantiate()
    
    // MARK: - Public methods
    public func getVCForSelectedCell(
        at indexPath: IndexPath
    ) -> UIViewController {
        let feature = features[indexPath.row]
        let destinationVC = feature.destinationVC.instantiate()
        destinationVC.title = feature.destinationVCTitle
        return destinationVC
    }
    
}
