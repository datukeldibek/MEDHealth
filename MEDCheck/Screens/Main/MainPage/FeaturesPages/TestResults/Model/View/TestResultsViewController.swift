//
//  TestResultsViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import UIKit

final class TestResultsViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = TestResultsViewModel()
    
    // MARK: - IBOutlets
    @IBOutlet weak var testResultsCollectionVIew: UICollectionView!
    
    // MARK: - Private methods
    private func configureTestResultsCollectionView() {
        testResultsCollectionVIew.dataSource = self
        testResultsCollectionVIew.delegate = self
        
        testResultsCollectionVIew.register(
            TestResultCollectionViewCell.nib,
            forCellWithReuseIdentifier: TestResultCollectionViewCell.identifier
        )
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTestResultsCollectionView()
    }
}

// MARK: - UICollectionViewDataSource
extension TestResultsViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { viewModel.results.count }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = testResultsCollectionVIew.dequeueReusableCell(
            withReuseIdentifier: TestResultCollectionViewCell.identifier,
            for: indexPath
        ) as? TestResultCollectionViewCell else { fatalError("xib not found") }
        cell.setup(with: viewModel.results[indexPath.row])
        cell.delegate = self
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TestResultsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: testResultsCollectionVIew.bounds.width / 2.15,
            height: testResultsCollectionVIew.bounds.height / 3.5
        )
    }
}

// MARK: - TestResultCollectionViewCellDelegate
extension TestResultsViewController: TestResultCollectionViewCellDelegate {
    func didSelectCell(at indexPath: IndexPath) {
        let vc = viewModel.setupDetailedTestResultVC(at: indexPath)
        present(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegate
extension TestResultsViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) { didSelectCell(at: indexPath) }
}

