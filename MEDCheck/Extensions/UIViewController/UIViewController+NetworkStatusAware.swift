//
//  UIViewController+NetworkStatusAware.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import UIKit
import NotificationBannerSwift

protocol NetworkStatusAware {
    func networkStatusDidChange(isConnected: Bool)
}

extension UIViewController: NetworkStatusAware {
    func observeNetworkStatusUpdates() {
        let networkStatusViewModel = NetworkStatusViewModel.shared
        networkStatusViewModel.statusDidChange = { [weak self] isConnected in
            guard let self = self else { return }
            self.networkStatusDidChange(isConnected: isConnected)
        }
    }

    func networkStatusDidChange(isConnected: Bool) {
        let title = isConnected ? "Интернет-соединение восстановлено" : "Интернет-соединение потеряно"
        let subtitle = "Свайпни вверх, чтоб скрыть уведомление."
        let style: BannerStyle = isConnected ? .success : .danger
        
        let banner = NotificationBanner(
            title: title,
            subtitle: subtitle,
            style: style
        )
        
        banner.show()
    }
}
