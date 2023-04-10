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
    private let imagePicker = UIImagePickerController()
    
    // MARK: - IBOutlets
    @IBOutlet weak var userProfilePictureImageView: UIImageView!
    @IBOutlet weak var userNameSurnameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var settingsTableView: UITableView!
    
    // MARK: - IBActions
    @IBAction func signOutButtonTapped(_ sender: Any) {
        viewModel.signOut()
    }
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showWarningAlert(title: "Ошибка", message: error)
            }
        }
        
        viewModel.goToSignInVC = { [weak self] in
            DispatchQueue.main.async {
                self?.goToSignInVC()
            }
        }
        
    }
    
    private func goToSignInVC() {
        let vc = UINavigationController(
            rootViewController: SignInViewController.instantiate()
        )
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
    }
    
    private func configureProfilePicImageView() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(profilePicImageViewTapped))
        userProfilePictureImageView.addGestureRecognizer(tapGesture)
        
        userProfilePictureImageView.layer.borderColor = UIColor.lightGray.cgColor
        userProfilePictureImageView.layer.borderWidth = 1
    }
    
    @objc
    private func profilePicImageViewTapped() {
        present(imagePicker, animated: true)
    }
    
    private func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    private func configureSettingsTableView() {
        settingsTableView.sizeToFit()
        settingsTableView.separatorColor = .clear
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        
        settingsTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "settings_cell"
        )
    }
    
    private func setDataToUIElements() {
        userProfilePictureImageView.image = viewModel.getProfilePicture()
        userNameSurnameLabel.text = viewModel.getUserDisplayName()
        userEmailLabel.text = viewModel.getUserEmail()
    }
    
    // MARK: - viewDidLoad(); viewWillAppear()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureProfilePicImageView()
        configureSettingsTableView()
        configureImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDataToUIElements()
    }
    
}

// MARK: - UINavigationControllerDelegate; UIImagePickerControllerDelegate
extension SettingsViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let pickedImage = info[.editedImage] as? UIImage else { return }
        viewModel.savePic(image: pickedImage)
        self.userProfilePictureImageView.image = pickedImage
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { viewModel.numberOfRows() }
        
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(
            withIdentifier: "settings_cell",
            for: indexPath
        )
        cell.textLabel?.text = viewModel.cellTitle(at: indexPath)
        cell.imageView?.image = viewModel.cellIcon(at: indexPath)
        configureUIForSettingCell(cell)
        return cell
    }
    
    private func configureUIForSettingCell(_ cell: UITableViewCell) {
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
    }
    
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) { viewModel.didSelectRow(at: indexPath) }
}
