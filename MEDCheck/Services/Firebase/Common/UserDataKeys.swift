//
//  UserDataKeys.swift
//  MEDCheck
//
//  Created by ibaikaa on 11/4/23.
//

import Foundation

public enum UserDataKeys: String {
    case uid = "uid"
    case name = "name"
    case surname = "surname"
    case email = "email"
    case password = "password"
    case profilePictureURL = "profilePictureURL"
}

public enum MedicationTakingDataKeys: String {
    case dayOfMonth = "dayOfMonth"
    case weekday = "weekday"
    case month = "month"
    case content = "content"
    case seconds = "seconds"
    case minutes = "minutes"
    case hour = "hour"
}
