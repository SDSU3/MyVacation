//
//  Vacation Model.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import Foundation
import Parse

class Vacation {
    var name: String
    var fromPlace: String
    var ToPlace: String
    var places: [String]
    var endDate: Date
    var startDate: Date
    var arrivalAirport: String
    var departureAirport: String
    var status: String
    var interestingPlaces: InterestingPlaces?
    
    init(name: String, fromPlace: String, ToPlace: String, places: [String], endDate: Date, startDate: Date, arrivalAirport: String, departureAirport: String, status: String) {
        self.name = name
        self.fromPlace = fromPlace
        self.ToPlace = ToPlace
        self.places = places
        self.endDate = endDate
        self.startDate = startDate
        self.arrivalAirport = arrivalAirport
        self.departureAirport = departureAirport
        self.status = status
    }
    
    init(with data: PFObject) {
        self.name = data["vacationName"] as? String ?? ""
        self.fromPlace = data["vacationFrom"] as? String ?? ""
        self.ToPlace = data["vacationTo"] as? String ?? ""
        self.places = data["vacationPlaces"] as? [String] ?? []
        self.endDate = data["vacationEndDate"] as? Date ?? Date()
        self.startDate = data["vacationStartDate"] as? Date ?? Date()
        self.arrivalAirport = data["vacationArrivalAirport"] as? String ?? ""
        self.departureAirport = data["vacationDepartureAirport"] as? String ?? ""
        self.status = data["vacationStatus"] as? String ?? "unknown"
    }
}
