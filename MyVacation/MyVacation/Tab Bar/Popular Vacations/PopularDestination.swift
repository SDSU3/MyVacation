//
//  PopularDestination.swift
//  MyVacation
//
//  Created by Dhiaa Bantan on 3/19/22.
//

import Foundation
import Parse

struct PopularDestination {
    
    var DestinationName: String = ""
    var VisitedNumber: Int = 0
    var FavoritedNumber: Int = 0
    
    init(DestinationName: String = "", VisitedNumber: Int = 0, FavoritedNumber: Int = 0) {
        self.DestinationName = DestinationName
        self.VisitedNumber = VisitedNumber
        self.FavoritedNumber = FavoritedNumber
    }
    
    init(with data: PFObject) {
        self.DestinationName = data[PopularDestination.ParserKeys.name] as? String ?? ""
        self.VisitedNumber = data[PopularDestination.ParserKeys.favorite] as? Int ?? 0
        self.FavoritedNumber = data[PopularDestination.ParserKeys.popular] as? Int ?? 0
    }
}

extension PopularDestination {
    struct ParserKeys {
        static let favorite = "favorite"
        static let popular = "popular"
        static let name = "placeName"
    }
}

enum PopularPlaceType: String {
    case visited = "visited"
    case favorite = "favorite"
}
