//
//  TestResultCollectionViewCell.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import UIKit

protocol TestResultCollectionViewCellDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath)
}

class TestResultCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties
    static let identifier = String(describing: TestResultCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    // MARK: - Delegate
    weak var delegate: TestResultCollectionViewCellDelegate? 
    
    // MARK: - IBOutlets
    @IBOutlet weak var testResultTitleLabel: UILabel!
    @IBOutlet weak var testResultDescriptionLabel: UILabel!
    
    // MARK: - Public methods
    public func setup(with testResult: TestResult) {
        testResultTitleLabel.text = testResult.title
        testResultDescriptionLabel.text = testResult.description
    }
}
