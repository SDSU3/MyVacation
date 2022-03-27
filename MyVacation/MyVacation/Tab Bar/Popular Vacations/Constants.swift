//
//  Constants.swift
//  MyVacation
//
//  Created by Dhiaa Bantan on 3/19/22.
//

import Foundation

struct Constants {
    static let FilterMenu = ["Name", "Visited", "Favorited"]
    static var SelectedDestination: PopularDestination = PopularDestination(DestinationName: "", VisitedNumber: -1, FavoritedNumber: -1, Details: "", ImageURL: "")
    static let DestinationCellID = "DestinationCell"
    static let DestinationInfoSegue = "DestinationInfoSegue"
}
