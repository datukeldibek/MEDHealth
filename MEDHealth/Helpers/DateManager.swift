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
    private let calendar = Calendar.current
    private let today = Date()
    
    private init() {
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    // MARK: - Public methods
    public func getToday() -> String { String(calendar.component(.day, from: today)) }
    
    public func getWeekday() -> String {
        let today = Date()
        let dayOfWeek = dateFormatter.string(from: today)
        return dayOfWeek
    }
    
    public func getMonth() -> String { String(calendar.component(.month, from: today)) }
    
    public func getSeconds() -> String { String(calendar.component(.second, from: today)) }
    
    public func getMinutes() -> String { String(calendar.component(.minute, from: today)) }
    
    public func getHours() -> String { String(calendar.component(.hour, from: today)) }
    
    public func getYear() -> String { String(calendar.component(.year, from: today)) }
    
    public func sortMedicationTaking(_ takings: [MedicationTaking]) -> [MedicationTaking] {
        return takings.sorted { taking1, taking2 in
            let taking1 = taking1
            let taking2 = taking2
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH-mm-ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let date1String = "\(taking1.month.prefix(3))-\(taking1.dayOfMonth)-\(getYear()) \(taking1.hour):\(taking1.minutes):\(taking1.seconds)"
            let date1 = dateFormatter.date(from: date1String)!
            
            let date2String = "\(taking2.month.prefix(3))-\(taking2.dayOfMonth)-\(getYear()) \(taking2.hour):\(taking2.minutes):\(taking2.seconds)"
            let date2 = dateFormatter.date(from: date2String)!
            
            return date1 > date2
        }
    }
    
    public func sortMedicationHistoryNotes(_ takings: [MedicalHistory]) -> [MedicalHistory] {
        return takings.sorted { taking1, taking2 in
            let taking1 = taking1
            let taking2 = taking2
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH-mm-ss"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")

            let date1String = "\(taking1.month.prefix(3))-\(taking1.dayOfMonth)-\(getYear()) \(taking1.hour):\(taking1.minutes):\(taking1.seconds)"
            let date1 = dateFormatter.date(from: date1String)!
            
            let date2String = "\(taking2.month.prefix(3))-\(taking2.dayOfMonth)-\(getYear()) \(taking2.hour):\(taking2.minutes):\(taking2.seconds)"
            let date2 = dateFormatter.date(from: date2String)!
            
            return date1 > date2
        }
    }
    
    public func refactorDateUnit(_ unit: String) -> String {
        guard unit.count == 1 else { return unit }
        return "0\(unit)"
    }
    
}
