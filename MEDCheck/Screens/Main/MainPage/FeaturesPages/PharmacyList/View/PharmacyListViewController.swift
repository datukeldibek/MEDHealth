//
//  PharmacyListViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

final class PharmacyListViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = PharmacyListViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var pharmaciesTableView: UITableView!
    
    // MARK: - Private methods
    private func configurePharmaciesTableView() {
        pharmaciesTableView.dataSource = self
        
        pharmaciesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "pharmacy_cell")
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePharmaciesTableView()
    }
}

// MARK: - UITableViewDataSource
extension PharmacyListViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int { viewModel.numberOfSections() }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { viewModel.section(at: section).numberOfRows }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        // Извлекаем компанию по индексу
        let company = viewModel.section(at: indexPath.section).company
        
        // Извлекаем все адреса для компании
        let addresses = viewModel.pharmacyAddresses(for: company)
        
        // Извлекаем определенный адрес по индексу
        let address = addresses[indexPath.row]
        
        // Создаем ячейку
        let cell = pharmaciesTableView
            .dequeueReusableCell(
                withIdentifier: "pharmacy_cell",
                for: indexPath
            )
        
        // Задаем текст для ячейки
        cell.textLabel?.text = address
        
        return cell
    }
  
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? { viewModel.section(at: section).title }
    
}

