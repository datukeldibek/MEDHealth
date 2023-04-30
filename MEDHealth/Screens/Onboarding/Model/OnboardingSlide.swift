//
//  OnboardingSlide.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import UIKit

struct OnboardingPage {
    let image: UIImage?
    let title, description: String
}

extension OnboardingPage {
    static func getOnboardings() -> [OnboardingPage] {
        [
            OnboardingPage(
                image: UIImage(named: "resultsImage"),
                title: "Заголовок 1".localized(),
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacinia libero ut metus convallis tempor. Vestibulum consequat, tortor mattis consequat".localized()
            ),
            
            OnboardingPage(
                image: UIImage(named: "historyImage"),
                title: "Заголовок 2".localized(),
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacinia libero ut metus convallis tempor. Vestibulum consequat, tortor mattis consequat".localized()
            ),
            
            OnboardingPage(
                image: UIImage(named: "recipeImage"),
                title: "Заголовок 3".localized(),
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus lacinia libero ut metus convallis tempor. Vestibulum consequat, tortor mattis consequat".localized()
            )
        ]
        
    }
}
