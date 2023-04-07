//
//  SafariOpener.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import SafariServices

protocol SafariOpenerProtocol {
    func openSafari(with url: URL)
}

final class SafariOpener: SafariOpenerProtocol {
    static let shared = SafariOpener()
    
    func openSafari(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        
        if let windowScene = UIApplication.shared
            .connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            
            let windows = windowScene.windows
            if let window = windows.first {
                window.rootViewController?.present(safariVC, animated: true)
            }
        }
    }
    
}
