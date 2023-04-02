//
//  NoInternetConnectionViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 29/3/23.
//

import UIKit
import JGProgressHUD

final class NoInternetConnectionViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = NoInternetConnectionViewModel()
    
    // MARK: - Private methods
    private func showLoadingHUD(isConnected: Bool) {
        let hud = JGProgressHUD(style: .dark)
        print("вызван метод загрузки")
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Проверяем..."
        hud.show(in: view)
        hud.dismiss(afterDelay: 1, animated: true) { [weak self] in
            DispatchQueue.main.async {
                self?.showResultHUD(isConnected: isConnected)
            }
        }
    }
    
    private func showConnectionRestoredHUD() {
        let hud = JGProgressHUD(style: .dark)
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.textLabel.text = "Интернет-соединение успешно восстановлено!"
        hud.show(in: view)
        hud.dismiss(afterDelay: 0.7, animated: true) { [weak self] in
            let vc = UINavigationController (
                rootViewController: SignInViewController.instantiate()
            )
            
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            self?.present(vc, animated: true)
        }
    }
    
    private func showNoConnectionHUD() {
        let hud = JGProgressHUD(style: .dark)
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.textLabel.text = "Нет интернет-соединения :("
        hud.show(in: view)
        hud.dismiss(afterDelay: 0.7, animated: true)
    }
    
    private func showResultHUD(isConnected: Bool) {
        isConnected ? showConnectionRestoredHUD() : showNoConnectionHUD()
    }
    
    // MARK: - IBActions
    @IBAction func checkConnectionAgain(_ sender: Any) {
        let isConnected = viewModel.connectionStatus()
        showLoadingHUD(isConnected: isConnected)
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
