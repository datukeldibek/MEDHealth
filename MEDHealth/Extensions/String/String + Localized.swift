//
//  String + Localized.swift
//  MEDCheck
//
//  Created by ibaikaa on 12/4/23.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
