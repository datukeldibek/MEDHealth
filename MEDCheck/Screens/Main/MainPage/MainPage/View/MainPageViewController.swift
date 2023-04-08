//
//  MainPageViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 2/4/23.
//

import UIKit

// VIEWMODELS: UserDefaults (name), MainViewModel
final class MainPageViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = MainPageViewModel()
    // MARK: - IBOutlets
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    
    // MARK: - Private methods
    private func configureFeaturesCollectionView() {
        featuresCollectionView.dataSource = self
        featuresCollectionView.delegate = self
        
        featuresCollectionView.register(
            FeatureCollectionViewCell.nib,
            forCellWithReuseIdentifier: FeatureCollectionViewCell.identifier
        )
    }
    
    private func configureNavigationBarTitle() {
        navigationController?
            .navigationBar
            .prefersLargeTitles = true
        
        navigationController?
            .navigationBar
            .largeTitleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 30, weight: .bold)
            ]
        
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitle()
        configureFeaturesCollectionView()
        observeNetworkStatusUpdates()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

// MARK: - UICollectionViewDataSource
extension MainPageViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { viewModel.features.count }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = featuresCollectionView.dequeueReusableCell(
            withReuseIdentifier: FeatureCollectionViewCell.identifier,
            for: indexPath
        ) as? FeatureCollectionViewCell else { fatalError("Xib not found") }
        cell.setup(with: viewModel.features[indexPath.row])
        cell.delegate = self
        return cell 
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize { CGSize(width: collectionView.bounds.width, height: 160) }
    
}

// MARK: - FeatureCollectionViewCellDelegate
extension MainPageViewController: FeatureCollectionViewCellDelegate {
    func didSelectCell(at indexPath: IndexPath) {
        let vc = viewModel.getVCForSelectedCell(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension MainPageViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) { didSelectCell(at: indexPath) }
}
