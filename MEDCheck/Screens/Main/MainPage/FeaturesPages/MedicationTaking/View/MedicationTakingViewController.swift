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
    
    // To shorten code.
    private var safeAreaLayoutGuide: ConstraintLayoutGuideDSL {
        view.safeAreaLayoutGuide.snp
    }
    
    // MARK: - UI Elements.
    
    // MARK: - No data UI Setup.
    private lazy var noDataContainerView = NoDataContainerView()
    private func setupNoDataUI() {
        medicationTakingsCollectionView.isHidden = true
        
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
    
    // MARK: - Data set UI Setup.
    private lazy var medicationTakingsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private func configureMedicationTakingsCollectionView() {
        medicationTakingsCollectionView.dataSource = self
        medicationTakingsCollectionView.delegate = self
        
        medicationTakingsCollectionView.register(
            MedicationTakingCell.nib,
            forCellWithReuseIdentifier: MedicationTakingCell.identifier
        )
    }
    
    private func setupDataSetUI() {
        noDataContainerView.isHidden = true
        view.addSubview(medicationTakingsCollectionView)
        medicationTakingsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.bottom).offset(-30)
        }
        setupCommonUI()
        configureMedicationTakingsCollectionView()
    }
    
    // MARK: - Common UI for both data states
    private lazy var addButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        button.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .white
        button.cornerRadius = button.frame.width / 2
        
        // add shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 4
        
        
        return button
    }()
    
    @objc
    private func addButtonTapped() {
        showAddMedicationTakingVC()
    }
    
    private func showAddMedicationTakingVC() {
        let vc = AddMedicationTakingViewController.instantiate()
        vc.title = "Добавление"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupCommonUI() {
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-150)
            make.height.width.equalTo(addButton.frame.width)
        }
    }
    
    // MARK: - viewModel init method
    private func initViewModel() {
        viewModel.showEmptyDataUI = { [weak self] in
            DispatchQueue.main.async {
                self?.setupNoDataUI()
            }
        }
        
        viewModel.showUIWithData = { [weak self] in
            DispatchQueue.main.async {
                self?.setupDataSetUI()
            }
        }
        
        viewModel.showInfoAlert = { [weak self] (title, message) in
            DispatchQueue.main.async {
                self?.showInfoAlert(title: title, message: message)
            }
        }
        
        viewModel.collectionViewReload = { [weak self] in
            DispatchQueue.main.async {
                self?.medicationTakingsCollectionView.reloadData()
            }
        }
        
    }
    
    // MARK: - UIViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.prepareUI()
    }
    
}

extension MedicationTakingViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { viewModel.numberOfItems() }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MedicationTakingCell.identifier,
            for: indexPath
        ) as? MedicationTakingCell else { fatalError("xib not found") }
        cell.setupCell(
            date: viewModel.date(at: indexPath),
            content: viewModel.content(at: indexPath)
        )
        return cell
    }
    
    
}

extension MedicationTakingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.bounds.width - 30,
            height: collectionView.bounds.height / 5
        )
    }
}
