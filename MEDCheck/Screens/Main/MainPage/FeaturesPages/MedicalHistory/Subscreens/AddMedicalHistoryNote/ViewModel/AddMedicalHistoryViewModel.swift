//
//  AddMedicalHistoryViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 14/4/23.
//

import Foundation

final class AddMedicalHistoryViewModel {
    // MARK: - Private properties
    private let db = FirebaseDatabaseManager.shared
    private let dateManager = DateManager.shared
    
    // MARK: - Public properties
    public var showInfoAlert: ((String, String) -> Void)?
    
    // MARK: - Public methods
    public func saveNewMedicalHistory(content: String) {
        guard let uid = AuthManager.shared.currentUser()?.uid else { return }
        db.saveNewMedicalHistoryNote(
            uid: uid,
            new: MedicalHistory(
                weekday: dateManager.getDayOfWeek(),
                dayOfMonth: dateManager.getToday(),
                month: dateManager.getMonth(),
                minutes: dateManager.getMinutes(),
                seconds: dateManager.getSeconds(),
                hour: dateManager.getHours(),
                content: content
            )
        ) { [weak self] error in
            if let error = error {
                self?.showInfoAlert?(
                    "Ошибка ⚠️".localized(),
                    error.localizedDescription
                )
            } else {
                self?.showInfoAlert?(
                    "Успех ✅".localized(),
                    "Успешно добавлено."
                )
            }
        }
    }
    
    
}
