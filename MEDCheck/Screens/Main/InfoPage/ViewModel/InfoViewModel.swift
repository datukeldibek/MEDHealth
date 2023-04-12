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
    private let supportPhoneNumber: String = "+996707550051"
    private let cells = InfoCellModel.instantiate()

    // MARK: - Public properties
    public var showAlert: ((String, String) -> Void)?
    public var goToDestinationVC: ((UIViewController) -> Void)?
    
    // MARK: - Public methods
    public func callPhoneNumber() {
        if
            let url = URL(string: "tel://\(supportPhoneNumber)"),
            app.canOpenURL(url) {
            app.open(url, options: [:], completionHandler: nil)
        } else {
            showAlert?("Ошибка ⚠️".localized(), "Попробуй чуть позже.".localized())
        }
    }
    
    public func numberOfRows() -> Int { cells.count + 1 }
    
    public func isCustomCell(at indexPath: IndexPath) -> Bool {
        indexPath.row > cells.count - 1 
    }
    
    public func infoCellTitle(at indexPath: IndexPath) -> String {
        cells[indexPath.row].title
    }
    
    public func didSelectRow(at indexPath: IndexPath)  {
        let selectedCell = cells[indexPath.row]
        switch selectedCell.attitude {
        case .goToSafari:
            guard let link = selectedCell.websiteLink else {
                showAlert?("Ошибка ⚠️", "Попробуй чуть позже.")
                return
            }
            helper.openSafari(with: link)
            return
        case .goToVC:
            guard let vc = selectedCell.destinationVC else {
                showAlert?("Ошибка ⚠️", "Попробуй чуть позже.")
                return
            }
            goToDestinationVC?(vc)
        }
    }
   
}
