//
//  OnboardingViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 30/3/23.
//

import UIKit

// MARK: - OnboardingViewController
final class OnboardingViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var onboardingsCollectionView: UICollectionView!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var skipOnboardingButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func pageControlTapped(_ sender: Any) {
        let indexPath = IndexPath(
            item: onboardingPageControl.currentPage,
            section: 0
        )
        currentPage = onboardingPageControl.currentPage
        onboardingsCollectionView.scrollToItem(
            at: indexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    @IBAction func skipOnboardingButtonTapped(_ sender: Any) {
        if viewModel.isOnboarded {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            viewModel.skipButtonTapped(
                currentPage: onboardingPageControl.currentPage
            )
        }
    }
    
    // MARK: - Private properties
    private var viewModel = OnboardingViewModel()
    private var slides: [OnboardingPage] { viewModel.onboardings }

    private var currentPage = 0 {
        didSet {
            onboardingPageControl.currentPage = currentPage
            if currentPage == slides.count - 1, !viewModel.isOnboarded {
                skipOnboardingButton.setTitle(
                    "Завершить обучение ✅".localized(),
                    for: .normal
                )
            } else {
                skipOnboardingButton.setTitle(
                    "Пропустить обучение ⏩".localized(),
                    for: .normal
                )
            }
        }
    }
    
    // MARK: - Private methods
    private func initViewModel() {
        viewModel.showAlert = { [weak self] title, message, onboarded in
            DispatchQueue.main.async {
                self?.showAlert(title: title, message: message, onboarded: onboarded)
            }
        }
    }
    
    private func showAlert(
        title: String,
        message: String,
        onboarded: Bool
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        if onboarded {
            let okAction = UIAlertAction(
                title: "Окей".localized(),
                style: .default
            ) { [weak self] _ in
                self?.viewModel.saveOnboarded()
                self?.goToSignInVC()
            }
            alert.addAction(okAction)
        } else {
            let cancelAction = UIAlertAction(
                title: "Отмена".localized(),
                style: .default
            )
            let skipAction = UIAlertAction(
                title: "Пропустить".localized(),
                style: .destructive
            ) { [weak self]_ in
                self?.viewModel.saveOnboarded()
                self?.goToSignInVC()
            }
            alert.addAction(cancelAction)
            alert.addAction(skipAction)
        }
        
        present(alert, animated: true)
    }
    
    private func goToSignInVC() {
        let signInVC = UINavigationController (
            rootViewController: SignInViewController.instantiate()
        )
        signInVC.modalPresentationStyle = .fullScreen
        signInVC.modalTransitionStyle = .crossDissolve
        present(signInVC, animated: true)
    }
    
    // MARK: – Configuring methods
    private func configureOnboardingsCollectionView() {
        onboardingsCollectionView.dataSource = self
        onboardingsCollectionView.delegate = self
        
        onboardingsCollectionView.register(
            OnboardingCollectionViewCell.nib,
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier
        )
    }
    
    private func configureOnboardingsPageControl() {
        onboardingPageControl.numberOfPages = slides.count
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        configureOnboardingsCollectionView()
        configureOnboardingsPageControl()
    }
    
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { slides.count }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = onboardingsCollectionView.dequeueReusableCell(
                withReuseIdentifier: OnboardingCollectionViewCell.identifier,
                for: indexPath
            ) as? OnboardingCollectionViewCell else {
            fatalError("Xib not found.")
        }
        cell.setup(with: slides[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.frame.width,
            height: collectionView.frame.height
        )
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        currentPage = Int(pageIndex)
    }
}


