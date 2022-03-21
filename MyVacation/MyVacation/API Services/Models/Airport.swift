//
//  Airport Model.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import Foundation

struct Airpots: Codable {
    var data: [Airport]
    
    private enum CodingKeys: String, CodingKey {
        case data = "response"
    }
}

struct Airport: Codable {
    var name: String
    var iataCode: String?
    var icaoCode: String?
    var lon: Double?
    var lat: Double?
    var city: String?
    var cityCode: String?
    var countryCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case iataCode = "iata_code"
        case icaoCode = "icao_code"
        case lon = "lng"
        case lat = "lat"
        case city = "city"
        case cityCode = "city_code"
        case countryCode = "country_code"
    }
}
