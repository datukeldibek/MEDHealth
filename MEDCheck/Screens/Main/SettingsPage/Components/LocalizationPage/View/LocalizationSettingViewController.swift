//
//  LocalizationSettingViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import UIKit

final class LocalizationSettingViewController: UIViewController {
    private let viewModel = LocalizationPageViewModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var languagesTableView: UITableView!
    
    private func configureLanguagesTableVeiw() {
        languagesTableView.dataSource = self
        languagesTableView.delegate = self
        
        languagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "language_cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLanguagesTableVeiw()
    }
}

extension LocalizationSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = languagesTableView.dequeueReusableCell(withIdentifier: "language_cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.cellTitle(at: indexPath)
        
        cell.accessoryType = viewModel.isCellSelected(at: indexPath) ? .checkmark : .none
        
        return cell
    }
    
    
}

extension LocalizationSettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        languagesTableView.reloadData()
    }
}
