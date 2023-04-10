//
//  SettingsViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 2/4/23.
//

import UIKit

// MARK: - SettingsViewController 
final class SettingsViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = SettingsViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var profilePicImageView: UIImageView!
    
    // MARK: - Private methods
    private func configureProfilePicImageView() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(profilePicImageViewTapped))
        profilePicImageView.addGestureRecognizer(tapGesture)
        
        profilePicImageView.layer.borderColor = UIColor.lightGray.cgColor
        profilePicImageView.layer.borderWidth = 1
    }
    
    @objc
    private func profilePicImageViewTapped() {
        let picker = createImagePicker()
        present(picker, animated: true)
    }
    
    private func createImagePicker() -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }
    
    // MARK: - viewDidLoad(); viewWillAppear()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfilePicImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let savedPicture = viewModel.getProfilePicture() else {
            profilePicImageView.image = UIImage(systemName: "person")
            return
        }
        profilePicImageView.image = savedPicture
    }
    
}

// MARK: - UINavigationControllerDelegate; UIImagePickerControllerDelegate
extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let pickedImage = info[.editedImage] as? UIImage {
            viewModel.saveProfilePicture(image: pickedImage)
            self.profilePicImageView.image = pickedImage
            picker.dismiss(animated: true)
        }

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
