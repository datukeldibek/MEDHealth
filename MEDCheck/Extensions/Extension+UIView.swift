//
//  Extension+UIView.swift
//  MEDCheck
//
//  Created by ibaikaa on 29/3/23.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    func setHapticFeedback(
        feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle
    ) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: feedbackStyle)
        impactFeedbackgenerator.impactOccurred()
    }
}
