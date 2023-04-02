//
//  NetworkManagerViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import Foundation

// MARK: - NetworkStatusObserver protocol
protocol NetworkStatusObserver: AnyObject {
    func networkStatusDidChange(isConnected: Bool)
}

// MARK: - NetworkStatusViewModel class
final class NetworkStatusViewModel: NetworkStatusObserver {
    // MARK: - Singleton
    static let shared = NetworkStatusViewModel()
    
    // MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - Public properties
    public var isConnected: Bool = false {
        didSet {
            statusDidChange?(isConnected)
        }
    }
    public var statusDidChange: ((Bool) -> Void)?

    // MARK: - Public methods
    public func networkStatusDidChange(isConnected: Bool) {
        print("Изменился нетворк статус: \(isConnected). был: \(self.isConnected)")
        self.isConnected = isConnected
    }
        
    // MARK: - init() and deinit
    private init () {
        print("Инит view model")
        networkManager.add(observer: self)
    }
    
    deinit {
        networkManager.remove(observer: self)
    }
}
