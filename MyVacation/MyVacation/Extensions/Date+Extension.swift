//
//  Date+Extension.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 25.03.22.
//

import Foundation

extension Date {
    func getFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
    
    func getDayAndMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "MMM dd"
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
    
    static func intToDate(_ intValue: Int) -> Date {
        let timeInterval = TimeInterval(intValue)
        return Date(timeIntervalSince1970: timeInterval)
    }
}
