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
        self.name = data[Vacation.ParserKeys.name] as? String ?? ""
        self.fromPlace = data[Vacation.ParserKeys.from] as? String ?? ""
        self.ToPlace = data[Vacation.ParserKeys.to] as? String ?? ""
        self.departureAirport = data[Vacation.ParserKeys.depAirport] as? String ?? ""
        self.arrivalAirport = data[Vacation.ParserKeys.arrAirport] as? String ?? ""
        self.startDate = data[Vacation.ParserKeys.startDate] as? Date ?? Date()
        self.endDate = data[Vacation.ParserKeys.endDate] as? Date ?? Date()
        self.places = data[Vacation.ParserKeys.places] as? [String] ?? []
        self.status = data[Vacation.ParserKeys.status] as? String ?? "unknown"
    }
    
    static func createVacationBody(newVacation: Vacation) -> PFObject {
        let vacation = PFObject(className: "Vacation")
        vacation[Vacation.ParserKeys.author] = PFUser.current()
        vacation[Vacation.ParserKeys.name] = newVacation.name
        vacation[Vacation.ParserKeys.from] = newVacation.fromPlace
        vacation[Vacation.ParserKeys.to] = newVacation.ToPlace
        vacation[Vacation.ParserKeys.depAirport] = newVacation.departureAirport
        vacation[Vacation.ParserKeys.arrAirport] = newVacation.arrivalAirport
        vacation[Vacation.ParserKeys.startDate] = newVacation.startDate
        vacation[Vacation.ParserKeys.endDate] = newVacation.endDate
        vacation[Vacation.ParserKeys.places] = newVacation.places
        vacation[Vacation.ParserKeys.status] = newVacation.status
        return vacation
    }
    
}

extension Vacation {
    struct ParserKeys {
        static let author = "vacationAuthor"
        static let name = "vacationName"
        static let from = "vacationFrom"
        static let to = "vacationTo"
        static let depAirport = "vacationDepartureAirport"
        static let arrAirport = "vacationArrivalAirport"
        static let startDate = "vacationStartDate"
        static let endDate = "vacationEndDate"
        static let places = "vacationPlaces"
        static let status = "vacationStatus"
    }
}
