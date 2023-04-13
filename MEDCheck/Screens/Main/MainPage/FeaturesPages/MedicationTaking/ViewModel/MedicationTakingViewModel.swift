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
    private let dateManager = DateManager.shared

    private var medicationTakings = [MedicationTaking]() {
        didSet {
            medicationTakings.isEmpty ? showEmptyDataUI?() : showUIWithData?()
        }
    }
    
    // MARK: - Private methods
    private func getMedicationTakings() {
        guard let uid = auth.currentUser()?.uid else {
            showInfoAlert? (
                "Ошибка ⚠️".localized(),
                "Неизвестная ошибка. Попробуйте еще раз.".localized()
            )
            return
        }
        
        db.getMedicationTakings(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.medicationTakings = dateManager.sortMedicationTaking(data)      
            case .failure(let error):
                self.showInfoAlert?(
                    "Ошибка ⚠️".localized(),
                    error.localizedDescription
                )
            }
        }
    }
    
    // MARK: - Public properties
    public var showEmptyDataUI: (() -> Void)?
    public var showUIWithData: (() -> Void)?
    public var showInfoAlert: ((String, String) -> Void)?
    public var collectionViewReload: ( () -> Void)?
    
    // MARK: - Public methods
    
    // MARK: - Setting UI state
    public func prepareUI() {
        guard medicationTakings.isEmpty else {
            showUIWithData?()
            collectionViewReload?()
            return
        }
        
        getMedicationTakings()
    }
    
    
    // MARK: - For UICollectionView protocols
    public func numberOfItems() -> Int { medicationTakings.count }
    
    public func content(at indexPath: IndexPath) -> String {
        medicationTakings[indexPath.row].content
    }
    
    public func date(at indexPath: IndexPath) -> String {
        medicationTakings[indexPath.row].weekday
    }
}
