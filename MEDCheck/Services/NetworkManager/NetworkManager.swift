//
//  NetworkManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import Reachability

// MARK: - NetworkStatusSubject protocol
protocol NetworkStatusSubject {
    func add(observer: NetworkStatusObserver)
    func remove(observer: NetworkStatusObserver)
    func notifyObservers(isConnected: Bool)
}

// MARK: - NetworkManager class
final class NetworkManager: NetworkStatusSubject {
    // MARK: - Singleton
    static let shared = NetworkManager()
    
    // MARK: - Private properties
    private let reachability = try? Reachability()
    private var observers = NSMutableSet()
    private var isConnected: Bool = true {
        didSet {
            print("Updated. Connected: \(isConnected). was: \(oldValue)")
            if isConnected != oldValue {
                print("notified observers")
                notifyObservers(isConnected: isConnected)
            }
        }
    }
    
    // MARK: - Private methods
    private func startMonitoring() {
        reachability?.whenReachable = { [weak self] _ in
            self?.isConnected = true
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.isConnected = false
        }
    
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func stopMonitoring() {
        reachability?.stopNotifier()
    }
    
    // MARK: - Public methods
    
    // MARK: – For observers
    public func add(observer: NetworkStatusObserver) {
        observers.add(observer)
    }
    
    public func remove(observer: NetworkStatusObserver) {
        observers.remove(observer)
    }
    
    public func notifyObservers(isConnected: Bool) {
        observers.forEach { observer in
            if let observer = observer as? NetworkStatusObserver {
                observer.networkStatusDidChange(isConnected: isConnected)
            } else {
                print("Could not cast observer as NetworkStatusObserver.")
            }
        }
    }
    
    // MARK: – Other public methods
    public func getConnectionStatus() -> Bool { isConnected }
    
    // MARK: - init() method
    private init () {
        if let reachability = reachability {
            isConnected = reachability.connection != .unavailable
        }
        startMonitoring()
    }
    
    deinit {
        stopMonitoring()
    }
    
}
