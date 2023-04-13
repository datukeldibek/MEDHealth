//
//  MedicationTakingViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import Foundation

final class MedicationTakingViewModel {
    // MARK: - Private properties
    private let db = FirebaseDatabaseManager.shared
    private let auth = AuthManager.shared

    private var medicationTakings = [MedicationTaking]() {
        didSet {
            medicationTakings.isEmpty ? showEmptyDataUI?() : showUIWithData?()
        }
    }
    
    // MARK: - Public properties
    public var showEmptyDataUI: (() -> Void)?
    public var showUIWithData: (() -> Void)?
    public var showInfoAlert: ((String, String) -> Void)?
    
    // MARK: - Public methods
    public func prepareUI() {
        guard medicationTakings.isEmpty else {
            showUIWithData?()
            return
        }
        
        getMedicationTakings()
    }
    
    private func getMedicationTakings() {
        guard let uid = auth.currentUser()?.uid else {
            showInfoAlert? (
                "Ошибка ⚠️".localized(),
                "Неизвестная ошибка. Попробуйте еще раз.".localized()
            )
            return
        }
        
        db.getMedicationTakings(uid: uid) { [weak self] result in
            switch result {
            case .success(let data):
                self?.medicationTakings = data
            case .failure(let error):
                self?.showInfoAlert?(
                    "Ошибка ⚠️".localized(),
                    error.localizedDescription
                )
            }
        }

    }
    
}
