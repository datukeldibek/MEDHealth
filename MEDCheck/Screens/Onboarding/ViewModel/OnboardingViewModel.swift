//
//  OnboardingViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 1/4/23.
//

import Foundation

final class OnboardingViewModel {
    // MARK: - Private properties
    private let defaults = UserDefaultsManager.shared
    
    // MARK: - Public properties
    public let onboardings = OnboardingPage.getOnboardings()
    public var showAlert: ( (String, String, Bool) -> Void)?
    public var isOnboarded: Bool {
        UserDefaultsManager.shared.retrieve(for: .isOnboarded) as? Bool ?? false
    }
    
    // MARK: - Public methods
    public func skipButtonTapped(currentPage: Int) {
        if currentPage == 2 {
            showAlert?(
                "Обучение завершено!",
                "Наслаждайтесь MEDCheck'ом!",
                true
            )
        } else {
            showAlert?(
                "Обучение не завершено!",
                "Вы уверены, что хотите пропустить обучение? Это действия нельзя будет отменить.",
                false
            )
        }
    }
    
    public func saveOnboarded() {
        defaults.save(value: true, for: .isOnboarded)
    }
}
