//
//  AddMedicationTakingViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 13/4/23.
//

import UIKit

final class AddMedicationTakingViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = AddMedicationTakingViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var medicationTakingTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard isCorrectInput() else { return }
        viewModel.saveNewMedicationTaking(content: medicationTakingTextField.text!)
    }
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showInfoAlert = { [weak self] (title, message) in
            DispatchQueue.main.async {
                self?.showInfoAlert(title: title, message: message)
            }
        }
    }
    
    private func isCorrectInput() -> Bool {
        guard medicationTakingTextField.hasText else {
            showInfoAlert(
                title: "Ошибка ⚠️".localized(),
                message: "Поле не может быть пустым!"
            )
            return false
        }
        
        return true
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
    
}
