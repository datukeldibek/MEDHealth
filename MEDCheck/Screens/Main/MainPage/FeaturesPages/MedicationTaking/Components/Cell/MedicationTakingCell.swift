//
//  MedicationTakingCell.swift
//  MEDCheck
//
//  Created by ibaikaa on 14/4/23.
//

import UIKit

class MedicationTakingCell: UICollectionViewCell {
    static let identifier = String(describing: MedicationTakingCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func setupCell(date: String, content: String) {
        dateLabel.text = date
        contentLabel.text = content
    }

}
