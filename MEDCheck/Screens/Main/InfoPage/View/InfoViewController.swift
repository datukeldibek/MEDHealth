//
//  InfoViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 2/4/23.
//

import UIKit

class InfoViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = InfoViewModel()
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = { [weak self] title, message in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.showWarningAlert(
                    title: title,
                    message: message
                )
            }
        }
        
        viewModel.goToDestinationVC = { [weak self] vc in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(
                    vc,
                    animated: true
                )
            }
        }
    }
    
    private func configureAppInfoTableView() {
        appInfoTableView.separatorColor = .clear
        appInfoTableView.dataSource = self
        appInfoTableView.delegate = self
        
        appInfoTableView.register(
            SocialMediaLinksTableViewCell.nib,
            forCellReuseIdentifier: SocialMediaLinksTableViewCell.identifier
        )
        
        appInfoTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "InfoCell"
        )
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var appInfoTableView: UITableView!
    
    // MARK: - IBActions
    @IBAction func callSupportButtonPressed(_ sender: Any) {
        viewModel.callPhoneNumber()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureAppInfoTableView()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

// MARK: - UITableViewDataSource
extension InfoViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { viewModel.numberOfRows() }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let isCustom = viewModel.isCustomCell(at: indexPath)
        if !isCustom {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "InfoCell",
                for: indexPath
            )
            cell.textLabel?.text = viewModel.infoCellTitle(at: indexPath)
            configureUIForInfoCell(cell)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SocialMediaLinksTableViewCell.identifier,
                for: indexPath
            )
            return cell
        }
    }
    
    private func configureUIForInfoCell(_ cell: UITableViewCell) {
        cell.imageView?.image = UIImage(systemName: "info.square")
        cell.imageView?.tintColor = .black
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
    }
    
}

// MARK: - UITableViewDelegate
extension InfoViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) { viewModel.didSelectRow(at: indexPath) }
    
}

