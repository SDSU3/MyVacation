//
//  Vacation Model.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import Foundation
import Parse
import UIKit

class Vacation {
    var name: String
    var fromPlace: String
    var ToPlace: String
    var endDate: Date
    var startDate: Date
    var arrivalAirport: String
    var departureAirport: String
    var position: [Double]?
    var status: VacationStatus
    var interestingPlaces: InterestingPlaces?
    var vacationObj: PFObject?
    
    init(name: String, fromPlace: String, ToPlace: String, places: InterestingPlaces? = nil, endDate: Date, startDate: Date, arrivalAirport: String, departureAirport: String, position: [Double], status: VacationStatus) {
        self.name = name
        self.fromPlace = fromPlace
        self.ToPlace = ToPlace
        self.endDate = endDate
        self.startDate = startDate
        self.arrivalAirport = arrivalAirport
        self.departureAirport = departureAirport
        self.position = position
        self.status = status
        self.interestingPlaces = places
    }
    
    init(with data: PFObject) {
        self.vacationObj = data
        self.name = data[Vacation.ParserKeys.name] as? String ?? ""
        self.fromPlace = data[Vacation.ParserKeys.from] as? String ?? ""
        self.ToPlace = data[Vacation.ParserKeys.to] as? String ?? ""
        self.departureAirport = data[Vacation.ParserKeys.depAirport] as? String ?? ""
        self.arrivalAirport = data[Vacation.ParserKeys.arrAirport] as? String ?? ""
        self.startDate = data[Vacation.ParserKeys.startDate] as? Date ?? Date()
        self.endDate = data[Vacation.ParserKeys.endDate] as? Date ?? Date()
        self.position = data[Vacation.ParserKeys.position] as? [Double] ?? []
        
        let places = data[Vacation.ParserKeys.places] as? [PFObject] ?? []
        interestingPlaces = InterestingPlaces()
        interestingPlaces?.places = places.map({ InterestingPlace(with: $0) })
        
        let newStatus = VacationStatus(rawValue: data[Vacation.ParserKeys.status] as? String ?? "") ?? .inactive
        self.status = newStatus
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
        vacation[Vacation.ParserKeys.position] = newVacation.position
        vacation[Vacation.ParserKeys.status] = newVacation.status.rawValue
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
        static let places = "InterestingPlaces"
        static let position = "position"
        static let status = "vacationStatus"
    }
}

enum VacationStatus: String {
    case inactive = "inactive"
    case active = "active"
    
    func getColor() -> UIColor {
        switch self {
        case .active:
            return UIColor.init(hexValue: 0x05F500)
        case .inactive:
            return UIColor.init(hexValue: 0xF57600)
        }
    }
}

