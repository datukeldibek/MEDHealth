//
//  MedicationTakingModel.swift
//  MEDCheck
//
//  Created by ibaikaa on 6/4/23.
//

import Foundation

struct MedicationTaking {
    var weekday, dayOfMonth, month, minutes, seconds, hour: String
    var content: String
    
    var date: String {
        "\(month) \(dayOfMonth), \(weekday)"
    }
}
