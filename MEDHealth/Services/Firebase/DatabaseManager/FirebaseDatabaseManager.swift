//
//  FirebaseDatabaseManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 9/4/23.
//

import FirebaseDatabase

let REF_USER = "users"

fileprivate enum FirebaseDatabaseErrors: Error {
    case snapshotError
}

final class FirebaseDatabaseManager {
    // MARK: - Singleton
    static let shared = FirebaseDatabaseManager()
    private init () { }
    
    // MARK: - Private properties
    private let ref = Database.database().reference()
    
    // MARK: - Private methods
    private func getUserReference(for uid: String) -> DatabaseReference {
        ref.child(REF_USER).child(uid)
    }
    
    private func getUserData(
        uid: String,
        completion: @escaping (Result<[String:Any], Error>) -> Void
    ) {
        let userRef = getUserReference(for: uid)
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String:Any] else {
                completion(.failure(FirebaseDatabaseErrors.snapshotError))
                return
            }
            
            completion(.success(userData))
        }
    }
    
    // MARK: - Public methods
    public func getUserPhotoURL(uid: String, completion: @escaping (Result<String, Error>) -> Void) {
        let userRef = getUserReference(for: uid)
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String:Any] else {
                completion(.failure(FirebaseDatabaseErrors.snapshotError))
                return
            }
            
            let urlPath = userData[UserDataKeys.profilePictureURL.rawValue] as? String ?? ""
            completion(.success(urlPath))
        }
    }
    
    
    public func saveUser(
        uid: String,
        name: String,
        surname: String,
        email: String,
        password: String,
        completion: @escaping ((Error?) -> Void)
    ) {
        let userData: [String:Any] = [
            UserDataKeys.uid.rawValue: uid,
            UserDataKeys.name.rawValue: name,
            UserDataKeys.surname.rawValue: surname,
            UserDataKeys.email.rawValue: email,
            UserDataKeys.password.rawValue: password,
            UserDataKeys.profilePictureURL.rawValue: "",
        ]
        
        let userRef = getUserReference(for: uid)
        
        userRef.updateChildValues(userData) { error, _ in
            completion(error)
        }
    }
    
    public func updateUserData(
        uid: String,
        newData: String,
        key: UserDataKeys,
        completion: @escaping ((Error?) -> Void)
    ) {
        getUserData(uid: uid) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(var userData):
                let userRef = self.ref.child(REF_USER).child(uid)
                userData[key.rawValue] = newData
                userRef.updateChildValues(userData) { error, ref in
                    completion(error)
                }
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    public func saveNewMedicationTaking(
        uid: String,
        new taking: MedicationTaking,
        completion: @escaping ((Error?) -> Void)
    ) {
        let userRef = getUserReference(for: uid)
        let newData: [String: Any] = [
            MedicationTakingDataKeys.dayOfMonth.rawValue: taking.dayOfMonth,
            MedicationTakingDataKeys.weekday.rawValue: taking.weekday,
            MedicationTakingDataKeys.month.rawValue: taking.month,
            MedicationTakingDataKeys.content.rawValue: taking.content,
            MedicationTakingDataKeys.seconds.rawValue: taking.seconds,
            MedicationTakingDataKeys.minutes.rawValue: taking.minutes,
            MedicationTakingDataKeys.hour.rawValue: taking.hour
        ]
        
        userRef
            .child("medicationTakings")
            .childByAutoId()
            .setValue(newData) { error, _ in
                completion(error)
            }
    }
    
    public func getMedicationTakings(
        uid: String,
        completion: @escaping (Result<[MedicationTaking], Error>) -> Void
    ) {
        let userRef = getUserReference(for: uid).child("medicationTakings")

        userRef.observe(.value) { snapshot, _ in
            guard let data = snapshot.value as? [String:Any] else {
                completion(.success([]))
                return
            }
            
            var medicationTakings = [MedicationTaking]()
            
            for takingData in data.values {
                if let takingData = takingData as? [String: Any],

                    let weekday = takingData[
                        MedicationTakingDataKeys.weekday.rawValue
                    ] as? String,
                   
                    let dayOfMonth = takingData[
                        MedicationTakingDataKeys.dayOfMonth.rawValue
                    ] as? String,
                   
                    let month = takingData[
                        MedicationTakingDataKeys.month.rawValue
                    ] as? String,
                   
                    let content = takingData[
                        MedicationTakingDataKeys.content.rawValue
                    ] as? String,
                   
                    let seconds = takingData[
                        MedicationTakingDataKeys.seconds.rawValue
                    ] as? String,
                   
                    let minutes = takingData[
                        MedicationTakingDataKeys.minutes.rawValue
                    ] as? String,
                   
                    let hour = takingData[
                        MedicationTakingDataKeys.hour.rawValue
                    ] as? String {
                    
                    let medicationTaking = MedicationTaking(
                        dayOfMonth: dayOfMonth,
                        month: month,
                        hour: hour,
                        minutes: minutes,
                        seconds: seconds,
                        weekday: weekday,
                        content: content
                    )
                    
                    medicationTakings.append(medicationTaking)
                }
            }
            
            completion(.success(medicationTakings))
        }
    }
    
    
    public func saveNewMedicalHistoryNote(
        uid: String,
        new note: MedicalHistory,
        completion: @escaping ((Error?) -> Void)
    ) {
        let userRef = getUserReference(for: uid)
        let newData: [String: Any] = [
            MedicationTakingDataKeys.dayOfMonth.rawValue: note.dayOfMonth,
            MedicationTakingDataKeys.weekday.rawValue: note.weekday,
            MedicationTakingDataKeys.month.rawValue: note.month,
            MedicationTakingDataKeys.content.rawValue: note.content,
            MedicationTakingDataKeys.seconds.rawValue: note.seconds,
            MedicationTakingDataKeys.minutes.rawValue: note.minutes,
            MedicationTakingDataKeys.hour.rawValue: note.hour
        ]
        
        userRef
            .child("medicalHistories")
            .childByAutoId()
            .setValue(newData) { error, _ in
                completion(error)
            }
    }
    
    public func getMedicalHistoryNotes(
        uid: String,
        completion: @escaping (Result<[MedicalHistory], Error>) -> Void
    ) {
        let userRef = getUserReference(for: uid).child("medicalHistories")

        userRef.observe(.value) { snapshot, _ in
            guard let data = snapshot.value as? [String:Any] else {
                completion(.success([]))
                return
            }
            
            var histories = [MedicalHistory]()
            
            for takingData in data.values {
                if let takingData = takingData as? [String: Any],

                    let weekday = takingData[
                        MedicationTakingDataKeys.weekday.rawValue
                    ] as? String,
                   
                    let dayOfMonth = takingData[
                        MedicationTakingDataKeys.dayOfMonth.rawValue
                    ] as? String,
                   
                    let month = takingData[
                        MedicationTakingDataKeys.month.rawValue
                    ] as? String,
                   
                    let content = takingData[
                        MedicationTakingDataKeys.content.rawValue
                    ] as? String,
                   
                    let seconds = takingData[
                        MedicationTakingDataKeys.seconds.rawValue
                    ] as? String,
                   
                    let minutes = takingData[
                        MedicationTakingDataKeys.minutes.rawValue
                    ] as? String,
                   
                    let hour = takingData[
                        MedicationTakingDataKeys.hour.rawValue
                    ] as? String {
                    
                    let note = MedicalHistory(
                        dayOfMonth: dayOfMonth,
                        month: month,
                        hour: hour,
                        minutes: minutes,
                        seconds: seconds,
                        weekday: weekday,
                        content: content
                    )
                    
                    histories.append(note)
                }
            }
            
            completion(.success(histories))
        }
    }
    
    
}
