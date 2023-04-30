//
//  LocalizationSettingViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import UIKit

final class LocalizationSettingViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = LocalizationPageViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var languagesTableView: UITableView!
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showInfoAlert = { [weak self] (title, message, languageCode) in
            DispatchQueue.main.async {
                self?.showInformationAlert(
                    title: title,
                    message: message,
                    languageCode: languageCode
                )
            }
        }
    }
    
    private func showInformationAlert(
        title: String,
        message: String,
        languageCode: String
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Окей".localized(),
                style: .default
            ) { [weak self] action in
                self?.viewModel.switchToLanguage(languageCode)
            }
        )
        
        present(alert, animated: true)
    }
    
    
    private func configureLanguagesTableVeiw() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        
        languagesTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "language_cell"
        )
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureLanguagesTableVeiw()
    }
    
}

// MARK: - UITableViewDataSource
extension LocalizationSettingViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { viewModel.numberOfRows() }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = languagesTableView.dequeueReusableCell(
            withIdentifier: "language_cell",
            for: indexPath
        )
        cell.textLabel?.text = viewModel.cellTitle(at: indexPath)
        cell.accessoryType = viewModel.isCellSelected(at: indexPath) ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension LocalizationSettingViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        viewModel.didSelectRow(at: indexPath)
        languagesTableView.reloadData()
    }
}
