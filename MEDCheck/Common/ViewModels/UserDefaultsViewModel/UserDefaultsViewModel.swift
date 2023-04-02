//
//  UserDefaultsViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import Foundation

final class UserDefaultsViewModel {
    // MARK: - Private properties
    private let userDefaults = UserDefaultsManager.shared
    
    // MARK: - Public properties
    public var showErrorBanner: ((String) -> Void)?
    
    // MARK: - Public methods
    public func save<T>(value: T, for key: UserDefaultsManager.Keys) {
        userDefaults.save(value: value, for: key)
    }
    
    public func retrieve(for key: UserDefaultsManager.Keys) -> Any? {
        userDefaults.retrieve(for: key)
    }
}
