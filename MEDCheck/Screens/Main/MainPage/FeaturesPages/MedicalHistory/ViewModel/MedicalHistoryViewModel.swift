//
//  MedicalHistoryViewModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import Foundation

final class MedicalHistoryViewModel {
    // MARK: - Private properties
    private let db = FirebaseDatabaseManager.shared
    private let auth = AuthManager.shared
    private let dateManager = DateManager.shared

    private var historyNotes = [MedicalHistory]() {
        didSet {
            historyNotes.isEmpty ? showEmptyDataUI?() : showUIWithData?()
        }
    }
    
    // MARK: - Private methods
    private func getMedicalHistoryNotes() {
        guard let uid = auth.currentUser()?.uid else {
            showInfoAlert? (
                "Ошибка ⚠️".localized(),
                "Неизвестная ошибка. Попробуйте еще раз.".localized()
            )
            return
        }
        
        db.getMedicalHistoryNotes(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.historyNotes = dateManager.sortMedicationHistoryNotes(data)
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
        guard historyNotes.isEmpty else {
            showUIWithData?()
            collectionViewReload?()
            return
        }
        
        getMedicalHistoryNotes()
    }
    
    
    // MARK: - For UICollectionView protocols
    public func numberOfItems() -> Int { historyNotes.count }
    
    public func content(at indexPath: IndexPath) -> String {
        historyNotes[indexPath.row].content
    }
    
    public func date(at indexPath: IndexPath) -> String {
        historyNotes[indexPath.row].date
    }
    
    public func medicationTaking(at indexPath: IndexPath) -> MedicalHistory {
        historyNotes[indexPath.row]
    }
}

