//
//  FeatureCollectionViewCell.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

protocol FeatureCollectionViewCellDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath)
}

final class FeatureCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties
    static let identifier = String(describing: FeatureCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    // MARK: - Delegate
    weak var delegate: FeatureCollectionViewCellDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var featureNameLabel: UILabel!
    @IBOutlet weak var featureIconImageView: UIImageView!
    
    // MARK: - Public methods
    public func setup(with feature: Feature) {
        featureNameLabel.text = feature.name
        featureIconImageView.image = feature.image
    }
}
