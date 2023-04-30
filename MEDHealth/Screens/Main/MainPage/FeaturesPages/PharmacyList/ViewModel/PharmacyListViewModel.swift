//
//  PharmacyListViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import Foundation

final class PharmacyListViewModel {
    // MARK: - Private properties
    private let pharmacies = PharmaciesList.shared.pharmacies
    private let companies = PharmacyCompany.allCases
    private var isFiltering: Bool = false
    private var filteredCompanies:[PharmacyCompany] = []
    private var filteredCompany: PharmacyCompany? = nil
    
    // MARK: - Private methods
    private func pharmacyAddresses(
        for key: PharmacyCompany
    ) -> [String] { pharmacies[key] ?? [] }
    
    // MARK: - Public methods
    public func numberOfSections() -> Int {
        isFiltering ? filteredCompanies.count : companies.count
    }
    
    public func numberOfRowsInSection(at section: Int) -> Int {
        if isFiltering {
            return pharmacyAddresses(for: filteredCompanies[section]).count
        } else {
            return pharmacyAddresses(for: companies[section]).count
        }
    }

    public func titleForHeader(at section: Int) -> String {
        if isFiltering {
            return filteredCompanies[section].rawValue
        } else {
            return companies[section].rawValue
        }
    }
    
    public func cellAddress(at indexPath: IndexPath) -> String? {
        let company = isFiltering ? filteredCompanies[indexPath.section] : companies[indexPath.section]
        let addresses = pharmacyAddresses(for: company)
        
        return indexPath.row < addresses.count ? addresses[indexPath.row] : nil
    }

    public func searchValue(for searchText: String) {
        guard !searchText.isEmpty else {
            filteredCompany = nil
            isFiltering = false
            return
        }
        isFiltering = true
        filteredCompanies = companies.filter { $0.rawValue.hasPrefix(searchText) }
    }
    
}
