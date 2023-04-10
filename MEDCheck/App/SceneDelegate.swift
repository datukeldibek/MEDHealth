//
//  SceneDelegate.swift
//  MEDCheck
//
//  Created by ibaikaa on 27/3/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(windowScene: windowScene)
        UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private var isConnected: Bool {
        NetworkManager.shared.getConnectionStatus() == true
    }
    
    private var isOnboarded: Bool {
        UserDefaultsManager.shared.retrieve(for: .isOnboarded) as? Bool ?? false
    }
    
    private var isSignedIn: Bool {
        AuthManager.shared.currentUser() != nil ? true : false
    }
    
    
    private var rootViewController: UIViewController {
        if !isOnboarded {
            return UINavigationController(
                rootViewController: OnboardingViewController.instantiate()
            )
        } else if isConnected {
            if isSignedIn {
                return UINavigationController(
                    rootViewController: MainTabBarController.instantiate()
                )
            } else {
                return UINavigationController(
                    rootViewController: SignInViewController.instantiate()
                )
            }
            
        } else {
            return NoInternetConnectionViewController.instantiate()
        }
    }
    
    private var titleTextAttributes: [NSAttributedString.Key: Any] {
        guard let font = UIFont(
            name: "RalewayRoman-Bold",
            size: 26
        ) else {
            print("Font is nil in SceneDelegate.")
            return [:]
        }
        return [.font:font]
    }
    
}

