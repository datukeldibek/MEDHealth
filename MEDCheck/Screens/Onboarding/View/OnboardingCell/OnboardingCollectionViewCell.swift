//
//  OnboardingCollectionViewCell.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    // MARK: - Static properties
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    // MARK: - IBOutlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Public methods
    public func setup(with slide: OnboardingPage) {
        iconImageView.image = slide.image
        titleLabel.text = slide.title
        descriptionLabel.text = slide.description
    }
}
