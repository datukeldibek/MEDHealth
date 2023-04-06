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
                title: "Сертификат вакцинации от COVID-2019",
                description: "Lorem ipsum dolor sit amet"),
            TestResult(
                title: "Результат ПЦР",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Анализ крови",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum dolor sit amet, conselectur Lorem ipsum Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Анализ 2",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Сердцебиение",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Анализ походки",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Сертификат вакцинации от COVID-2019",
                description: "Lorem ipsum dolor sit amet"),
            TestResult(
                title: "Результат ПЦР",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Анализ крови",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Анализ 2",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Сердцебиение",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum"),
            TestResult(
                title: "Анализ походки",
                description: "Lorem ipsum dolor sit amet, conselectur Lorem ipsum")
        ]
    }
}
