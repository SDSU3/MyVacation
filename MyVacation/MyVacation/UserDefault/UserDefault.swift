//
//  UserDefault.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 25.03.22.
//

import UIKit

class UDManager {
    internal static let INTERFACESTYLE = "InterfaceStyle"
    internal static let TIMEZONE = "TIMEZONE"
    
    static func getUD() -> UserDefaults {
        return UserDefaults.standard
    }
    
    static func saveUserInterfaceStyle(style: Int) {
        getUD().set(style, forKey: INTERFACESTYLE)
    }
    
    static func getUserinterfaceStyle() -> UIUserInterfaceStyle {
        let style = getUD().integer(forKey: INTERFACESTYLE)
        return style == 2 ? .dark : .light
    }
    
    static func saveUserTimeZone(timeZone: String) {
        getUD().set(timeZone, forKey: TIMEZONE)
    }
    
    static func getUserTimeZone() -> String? {
        return getUD().string(forKey: TIMEZONE)
    }
}
