//
//  MainPageViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import Foundation

final class MainPageViewModel {
    // MARK: - Private properties
    private var defaults = UserDefaultsManager.shared
    // MARK: - Public properties
    public let features = Feature.instantiate()
}
