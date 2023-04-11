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
    private func configureLanguagesTableVeiw() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        
        languagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "language_cell")
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
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
