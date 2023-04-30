//
//  MedicalHistoryModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import Foundation

/// История болезни
struct MedicalHistory {
    private let dateManager = DateManager.shared

    var dayOfMonth: String
    var month: String
    var hour: String
    var minutes: String
    var seconds: String
    var weekday: String
    var content: String
    
    init(dayOfMonth: String, month: String, hour: String, minutes: String, seconds: String, weekday: String, content: String) {
        self.dayOfMonth = dateManager.refactorDateUnit(dayOfMonth)
        self.month = dateManager.refactorDateUnit(month)
        self.hour = dateManager.refactorDateUnit(hour)
        self.minutes = dateManager.refactorDateUnit(minutes)
        self.seconds = dateManager.refactorDateUnit(seconds)
        self.weekday = weekday
        self.content = content
    }
    
    var date: String {
        return "\(dayOfMonth).\(month).\(dateManager.getYear()), \(weekday.localized())"
    }
}
