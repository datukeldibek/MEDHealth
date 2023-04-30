//
//  TestResultDetailedVC.swift
//  MEDCheck
//
//  Created by ibaikaa on 7/4/23.
//

import UIKit
import SnapKit

final class TestResultDetailedVC: UIViewController {
    // MARK: - Private properties
    private lazy var testResultTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RalewayRoman-Bold", size: 26)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var testResultDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RalewayRoman-Medium", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Private methods
    private func initUI() {
        view.backgroundColor = .white
        
        view.addSubview(testResultTitleLabel)
        
        testResultTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-100)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        
        view.addSubview(testResultDescriptionLabel)
        testResultDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(testResultTitleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Public methods
    public func setup(with result: TestResult) {
        testResultTitleLabel.text = result.title
        testResultDescriptionLabel.text = result.description
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
}
