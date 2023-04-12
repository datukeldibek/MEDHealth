//
//  InfoCellModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import UIKit

struct InfoCellModel {
    enum AttitudeOnTap {
        case goToSafari, goToVC
    }
    
    var title: String
    var attitude: AttitudeOnTap
    var websiteLink: URL?
    var destinationVC: UIViewController?
}

extension InfoCellModel {
    static func instantiate() -> [InfoCellModel] {
        [
            InfoCellModel(
                title: "Пользовательское соглашение".localized(),
                attitude: .goToSafari,
                websiteLink: URL(
                    string: "https://www.medcheck.kg/terms-of-use"
                ),
                destinationVC: nil
            ),
            
            InfoCellModel(
                title: "О нас".localized(),
                attitude: .goToSafari,
                websiteLink: URL(
                    string: "https://www.medcheck.kg/about"
                ),
                destinationVC: nil 
            ),
            
            InfoCellModel(
                title: "О приложении".localized(),
                attitude: .goToVC,
                websiteLink: nil,
                destinationVC: AboutAppViewController.instantiate()
            )
        ]
    }
}
