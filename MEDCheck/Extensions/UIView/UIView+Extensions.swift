//
//  Extension+UIView.swift
//  MEDCheck
//
//  Created by ibaikaa on 29/3/23.
//

import UIKit

extension UIView {
    @IBInspectable var isCircular: Bool {
        get {
            return layer.cornerRadius == min(bounds.width, bounds.height) / 2
        }
        set {
            layer.cornerRadius = newValue ? frame.size.height / 2 : 0
            layer.masksToBounds = false
            clipsToBounds = true
        }
    }
    
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
