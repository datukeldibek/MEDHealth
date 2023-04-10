//
//  FirebaseStorageManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import Foundation
import FirebaseStorage

let REF_PROFILE_PICS  = "profile pictures"
let URL_STORAGE_ROOT =  "gs://medcheck-3800d.appspot.com"

final class FirebaseStorageManager {
    // MARK: - Singleton
    static let shared = FirebaseStorageManager()
    private init () { }
    
    // MARK: - Private properties
    private var ref: StorageReference {
        Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    }
    
    private let authManager = AuthManager.shared
    private let db = FirebaseDatabaseManager.shared
    
    // MARK: - Public methods
    func saveProfilePictureImage(
        userID uid: String,
        imageData: Data,
        completion: @escaping ((Error?) -> Void)
    ) {
        let storageProfileRef = ref.child(REF_PROFILE_PICS).child(uid)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        storageProfileRef.putData(imageData, metadata: metadata) { metadata, error in
            completion(error)
        }
        
        storageProfileRef.downloadURL { [weak self] url, error in
            guard
                let self = self,
                let url = url?.absoluteString
            else { return }
            
            print("URL: \(url)")
            
            self.db.updateUserData(
                uid: uid,
                newData: url,
                key: .profilePictureURL
            ) { error in
                completion(error)
            }
        }
    }
    
}

