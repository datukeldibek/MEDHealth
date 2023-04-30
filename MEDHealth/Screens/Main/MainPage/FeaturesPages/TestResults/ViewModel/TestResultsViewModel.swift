//
//  TestResultsViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

final class TestResultsViewModel {
    // MARK: - Private properties
    private var defaults = UserDefaultsManager.shared
    
    // MARK: - Public properties
    public let results = TestResult.instantiate()
    
    // MARK: - Public methods
    public func setupDetailedTestResultVC(at indexPath: IndexPath) -> TestResultDetailedVC {
        let vc = TestResultDetailedVC()
        if let bottomSheet = vc.sheetPresentationController {
            bottomSheet.detents = [.medium()]
        }
        vc.setup(with: results[indexPath.row])
        return vc
    }
}

