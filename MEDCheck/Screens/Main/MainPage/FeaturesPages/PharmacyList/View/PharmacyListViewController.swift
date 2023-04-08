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
    @IBOutlet weak var searchPharmacySearchBar: UISearchBar!
    @IBOutlet weak var pharmaciesTableView: UITableView!
    
    // MARK: - Private methods
    private func configureSearchPharmacySearchBar () {
        searchPharmacySearchBar.delegate = self
    }
    
    private func configurePharmaciesTableView() {
        pharmaciesTableView.dataSource = self
        
        pharmaciesTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "pharmacy_cell"
        )
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchPharmacySearchBar()
        configurePharmaciesTableView()
        
        // From extension. FILE: UIViewController+KeyboardHandling.swift
        configureViewTappedHandling()
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
    ) -> Int {  viewModel.numberOfRowsInSection(at: section) }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell = pharmaciesTableView
            .dequeueReusableCell(
                withIdentifier: "pharmacy_cell",
                for: indexPath
            )
        
        cell.textLabel?.text = viewModel.cellAddress(at: indexPath)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? { viewModel.titleForHeader(at: section) }
    
}

// MARK: - UISearchBarDelegate
extension PharmacyListViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        viewModel.searchValue(for: searchText)
        pharmaciesTableView.reloadData()
    }
    
}
