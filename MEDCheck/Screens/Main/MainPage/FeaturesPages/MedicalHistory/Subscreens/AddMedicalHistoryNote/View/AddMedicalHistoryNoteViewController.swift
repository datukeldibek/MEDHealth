//
//  AddMedicalHistoryNoteViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 14/4/23.
//

import UIKit
import SnapKit
final class AddMedicalHistoryNoteViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = AddMedicalHistoryViewModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var medicalHistoryNoteTF: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        viewModel.saveNewMedicalHistory(content: medicalHistoryNoteTF.text!)
        
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
        guard medicalHistoryNoteTF.hasText else {
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
