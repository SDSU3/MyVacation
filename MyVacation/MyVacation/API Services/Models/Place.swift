//
//  Place Model.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import Foundation

struct Place: Codable {
    var country: String?
    var timezone: String?
    var name: String
    var lon: Double?
    var lat: Double?
    var population: Int?
    var isCapital: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case country = "country"
        case timezone = "timezone"
        case name = "name"
        case lon = "longitude"
        case lat = "latitude"
        case population = "population"
        case isCapital = "is_capital"
    }
}
