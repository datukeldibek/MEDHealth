//
//  MedicalHistoryCollectionViewCell.swift
//  MEDCheck
//
//  Created by ibaikaa on 14/4/23.
//

import UIKit

final class MedicalHistoryCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: MedicalHistoryCollectionViewCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    public func setupCell(date: String, content: String) {
        dateLabel.text = date
        contentLabel.text = content
    }

}
