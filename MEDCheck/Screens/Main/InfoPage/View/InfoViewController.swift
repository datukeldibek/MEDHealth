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
    
    // MARK: - IBOutlets
    @IBOutlet weak var appInfoTableView: UITableView!
    
    // MARK: - IBActions
    @IBAction func callSupportButtonPressed(_ sender: Any) {
        viewModel.callPhoneNumber()
    }
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showWarningAlert(
                    title: "Ошибка!",
                    message: "Неизвестная ошибка. Попробуй еще раз чуть позже."
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
        
        appInfoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "InfoCell")
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureAppInfoTableView()
    }
}

// MARK: - UITableViewDataSource
extension InfoViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { viewModel.cells.count + 1 }
    
    private func configureUIForInfoCell(_ cell: UITableViewCell) {
        cell.imageView?.image = UIImage(systemName: "arrow.right.square")
        cell.backgroundColor = .clear
        
        // Selected state custom
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(
            red: 193/255,
            green: 233/255,
            blue: 255/255,
            alpha: 1
        )
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.lightGray.cgColor
        cell.selectedBackgroundView = backgroundView
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let isCustom = indexPath.row > viewModel.cells.count - 1
        if !isCustom {
            let option = viewModel.cells[indexPath.row]
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "InfoCell",
                for: indexPath
            )
            cell.textLabel?.text = option.title
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
    
}

// MARK: - UITableViewDelegate
extension InfoViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let vc = viewModel.didSelectRow(at: indexPath) else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
