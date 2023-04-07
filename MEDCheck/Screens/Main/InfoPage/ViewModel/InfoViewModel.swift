//
//  InfoViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import UIKit

final class InfoViewModel {
    // MARK: - Private properties
    private let app = UIApplication.shared
    private let helper = SafariOpener.shared
    private let supportPhoneNumber: String = "+996700125170"
    
    // MARK: - Public properties
    public let cells = InfoCellModel.instantiate()
    public var showAlert: (() -> Void)?
    
    // MARK: - Public methods
    public func callPhoneNumber() {
        if
            let url = URL(string: "tel://\(supportPhoneNumber)"),
            app.canOpenURL(url) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            showAlert?()
        }
    }
    
    public func didSelectRow(at indexPath: IndexPath) -> UIViewController? {
        let selectedCell = cells[indexPath.row]
        switch selectedCell.attitude {
        case .goToSafari:
            guard let link = selectedCell.websiteLink else {
                showAlert?()
                return nil
            }
            helper.openSafari(with: link)
            return nil
        case .goToVC:
            guard let vc = selectedCell.destinationVC else {
                showAlert?()
                return nil
            }
            return vc
        }
    }
 
}
