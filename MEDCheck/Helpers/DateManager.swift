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
    
    public func getSeconds() -> String {
        let today = Date()
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: today)
        return "\(seconds)"
    }
    
    public func getMinutes() -> String {
        let today = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: today)
        return "\(minutes)"
    }
    
    public func getHours() -> String {
        let today = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: today)
        return "\(hour)"
    }
    
    private func getYear() -> String {
        let today = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: today)
        return "\(year)"
    }
    
    
    public func sortMedicationTaking(_ takings: [MedicationTaking]) -> [MedicationTaking] {
        return takings.sorted { taking1, taking2 in
            let taking1 = taking1
            let taking2 = taking2
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-yyyy HH:mm:ss"
            
            let date1 = dateFormatter.date(
                from: "\(taking1.month.prefix(3))-\(taking1.dayOfMonth)-\(getYear()) \(taking1.hour):\(taking1.minutes):\(taking1.seconds)"
            )!
            
            let date2 = dateFormatter.date(
                from: "\(taking2.month.prefix(3))-\(taking2.dayOfMonth)-\(getYear()) \(taking2.hour):\(taking2.minutes):\(taking2.seconds)"
            )!
            
            return date1 > date2
        }
    }
    
    public func sortMedicationHistoryNotes(_ takings: [MedicalHistory]) -> [MedicalHistory] {
        return takings.sorted { taking1, taking2 in
            let taking1 = taking1
            let taking2 = taking2
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-yyyy HH:mm:ss"
            
            let date1 = dateFormatter.date(
                from: "\(taking1.month.prefix(3))-\(taking1.dayOfMonth)-\(getYear()) \(taking1.hour):\(taking1.minutes):\(taking1.seconds)"
            )!
            
            let date2 = dateFormatter.date(
                from: "\(taking2.month.prefix(3))-\(taking2.dayOfMonth)-\(getYear()) \(taking2.hour):\(taking2.minutes):\(taking2.seconds)"
            )!
            
            return date1 > date2
        }
    }
    
}
