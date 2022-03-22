//
//  Plan.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 21.03.22.
//

import Foundation

class Plan {
    var name: String
    var from: String
    var to: String
    var startDate: Date
    var endDate: Date
    var departure: String
    var arrival: String
    
    init(name: String, from: String, to: String, startDate: Date, endDate: Date, departure: String, arrival: String) {
        self.name = name
        self.from = from
        self.to = to
        self.startDate = startDate
        self.endDate = endDate
        self.departure = departure
        self.arrival = arrival
    }
    
}
