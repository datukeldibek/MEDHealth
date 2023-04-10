//
//  UserDefaultsManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import Foundation

final class UserDefaultsManager {
    // MARK: - Singleton
    static let shared = UserDefaultsManager()
    private init () { }
    
    // MARK: - Private properties
    private let defaults = UserDefaults.standard

    // MARK: - Public properties
    enum Keys: String {
        case isOnboarded = "isOnboarded"
        case chosenImage = "chosenImage"
        case authVerification = "authVerification"
    }
    
    // MARK: - Public methods
    public func save<T> (value: T, for key: Keys) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    public func retrieve(for key: Keys) -> Any? {
        defaults.object(forKey: key.rawValue)
    }
}
