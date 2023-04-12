//
//  Feature.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

struct Feature {
    var name: String
    var image: UIImage?
    var destinationVC: UIViewController.Type
}

extension Feature {
    static func instantiate() -> [Feature] {
        [
            Feature(
                name: "Прием лекарств".localized(),
                image: UIImage(named: "takingMedicationsImage"),
                destinationVC: MedicationTakingViewController.self
            ),
            
            Feature(
                name: "История болезни".localized(),
                image: UIImage(named: "diseaseHistoryImage"),
                destinationVC: MedicalHistoryViewController.self
            ),
            
            Feature(
                name: "Результаты анализов".localized(),
                image: UIImage(named: "analysisResultsImage"),
                destinationVC: TestResultsViewController.self
            ),
            
            Feature(
                name: "Список аптек".localized(),
                image: UIImage(named: "pharmaciesListImage"),
                destinationVC: PharmacyListViewController.self
            )
        ]
    }
}
