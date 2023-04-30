//
//  NoInternetConnectionViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import Foundation

final class NoInternetConnectionViewModel {
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public methods
    public func connectionStatus() -> Bool { networkManager.getConnectionStatus() }
}
