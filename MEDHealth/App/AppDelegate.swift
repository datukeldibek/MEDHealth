//
//  AppDelegate.swift
//  MEDCheck
//
//  Created by ibaikaa on 27/3/23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var language: String {
        UserDefaultsManager.shared.retrieve(for: .appLanguage) as? String ?? Locale.preferredLanguages.first ?? "en"
    }
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        UserDefaultsManager.shared.save(value: language, for: .appLanguage)
        return true
    }

}

