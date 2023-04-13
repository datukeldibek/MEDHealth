//
//  DateManager.swift
//  MEDCheck
//
//  Created by ibaikaa on 13/4/23.
//

import Foundation

final class DateManager {
    // MARK: - Singleton
    static let shared = DateManager()
    
    // MARK: - Private properties
    private let dateFormatter = DateFormatter()
    
    private init() { dateFormatter.dateFormat = "EEEE" }
    
    // MARK: - Public methods
    public func getToday() -> String {
        let today = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: today)
        return "\(day)"
    }
    
    public func getDayOfWeek() -> String {
        let today = Date()
        let dayOfWeek = dateFormatter.string(from: today)
        print(dayOfWeek)
        return dayOfWeek
    }
    
    public func getMonth() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: today)
        return month
    }
}
