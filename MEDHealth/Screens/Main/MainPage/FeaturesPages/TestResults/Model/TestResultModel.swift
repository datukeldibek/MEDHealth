//
//  TestResultModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import Foundation

struct TestResult {
    var title, description: String
}

extension TestResult {
    static func instantiate() -> [TestResult] {
        [
            TestResult(
                title: "Сертификат вакцинации от COVID-2019".localized(),
                description: "Lorem ipsum dolor sit amet".localized()
            ),
            TestResult(
                title: "Результат ПЦР".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Анализ крови".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum dolor sit amet, conselectur Lorem ipsum Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Анализ 2".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Сердцебиение".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Анализ походки".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Сертификат вакцинации от COVID-2019".localized(),
                description: "Lorem ipsum dolor sit amet".localized()
            ),
            TestResult(
                title: "Результат ПЦР".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Анализ крови".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Анализ 2".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Сердцебиение".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            ),
            TestResult(
                title: "Анализ походки".localized(),
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum".localized()
            )
        ]
    }
}
