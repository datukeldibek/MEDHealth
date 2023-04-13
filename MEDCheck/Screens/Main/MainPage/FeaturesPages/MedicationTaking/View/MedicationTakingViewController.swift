//
//  MedicationTakingViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit
import SnapKit

final class MedicationTakingViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = MedicationTakingViewModel()
    
    // MARK: - UI Elements.
    private lazy var noDataContainerView = NoDataContainerView()
    
    private func setupNoDataUI() {
        view.addSubview(noDataContainerView)
        
        noDataContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        noDataContainerView.setupSubviews()
        
        setupCommonUI()
    }
    
    private lazy var medicationTakingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .red
        
        return collectionView
    }()
    
    private func setupDataSetUI() {
        view.addSubview(medicationTakingsCollectionView)
        
        medicationTakingsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        setupCommonUI()
    }
    
    private lazy var addMedicationTakingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        
        button.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
        
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .white
        button.cornerRadius = button.frame.width / 2
        return button
        
    }()
    
    @objc
    private func addButtonTapped() {
        showAddMedicationTakingVC()
    }
    
    private func setupCommonUI() {
        view.addSubview(addMedicationTakingButton)
        
        addMedicationTakingButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-100)
            make.height.width.equalTo(addMedicationTakingButton.frame.width)
        }
    }
    
    private func showAddMedicationTakingVC() {
        let vc = AddMedicationTakingViewController.instantiate()
        vc.title = "Добавление"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNoDataUI()
        setupDataSetUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}
