//
//  PharmacyListViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import Foundation

struct Section {
    let title: String
    let numberOfRows: Int
    let company: PharmacyListModel.PharmacyCompany
}

final class PharmacyListViewModel {
    private let pharmaciesList = PharmacyListModel()
    private let companies = PharmacyListModel.PharmacyCompany.allCases
    
    public func pharmacyAddresses(
        for key: PharmacyListModel.PharmacyCompany
    ) -> [String] { pharmaciesList.pharmacies[key] ?? [] }
    
    public func numberOfSections() -> Int { companies.count }
    
    public func section(at index: Int) -> Section {
        let company = companies[index]
        let pharmacyAddresses = pharmacyAddresses(for: company)
        return Section(
            title: company.rawValue,
            numberOfRows: pharmacyAddresses.count,
            company: company
        )
    }
    
}
