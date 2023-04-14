//
//  MedicationTakingDetailedViewController.swift
//  MEDCheck
//
//  Created by ibaikaa on 14/4/23.
//

import UIKit
import SnapKit

final class MedicationTakingDetailedViewController: UIViewController {
    // MARK: - Private properties
    private lazy var takingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "RalewayRoman-Bold", size: 26)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var takingDescriptionLabel: UILabel = {
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
        
        view.addSubview(takingTitleLabel)
        
        takingTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        
        view.addSubview(takingDescriptionLabel)
        takingDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(takingTitleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Public methods
    public func setup(with taking: MedicationTaking) {
        takingTitleLabel.text  = taking.date
        takingDescriptionLabel.text = taking.content
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
}

