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
    var destinationVCTitle: String
}

extension Feature {
    static func instantiate() -> [Feature] {
        [
            Feature(
                name: "Прием лекарств",
                image: UIImage(named: "takingMedicationsImage"),
                destinationVC: MedicationTakingViewController.self,
                destinationVCTitle: "Прием лекарств 💊"
            ),
            
            Feature(
                name: "История болезни",
                image: UIImage(named: "diseaseHistoryImage"),
                destinationVC: MedicalHistoryViewController.self,
                destinationVCTitle: "История болезни 🩺"
            ),
            
            Feature(
                name: "Результаты анализов",
                image: UIImage(named: "analysisResultsImage"),
                destinationVC: TestResultsViewController.self,
                destinationVCTitle: "Результаты анализов 🗒️"
            ),
            
            Feature(
                name: "Список аптек",
                image: UIImage(named: "pharmaciesListImage"),
                destinationVC: PharmacyListViewController.self,
                destinationVCTitle: "Список аптек 🏥"
            )
        ]
    }
}
