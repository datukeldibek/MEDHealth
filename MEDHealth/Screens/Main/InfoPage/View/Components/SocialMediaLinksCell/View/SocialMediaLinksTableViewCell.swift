//
//  SocialMediaLinksTableViewCell.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import UIKit

class SocialMediaLinksTableViewCell: UITableViewCell {
    // MARK: - Static properties
    static let identifier = String(describing: SocialMediaLinksTableViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    // MARK: - Private properties
    private let viewModel = SocialMediaLinksViewModel()
    
    // MARK: - IBOutlets
    @IBAction func facebookButtonTapped(_ sender: Any) {
        viewModel.openFacebookPage()
    }
    
    @IBAction func instagramButtonTapped(_ sender: Any) {
        viewModel.openInstagramPage()
    }
}
