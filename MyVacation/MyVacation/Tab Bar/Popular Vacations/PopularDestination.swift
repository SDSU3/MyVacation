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
    var Details: String = ""
    var ImageURL: String = ""
    
    init(DestinationName: String = "", VisitedNumber: Int = 0, FavoritedNumber: Int = 0, Details: String = "", ImageURL: String = "") {
        self.DestinationName = DestinationName
        self.VisitedNumber = VisitedNumber
        self.FavoritedNumber = FavoritedNumber
        self.Details = Details
        self.ImageURL = ImageURL
        
    }
    
    init(with data: PFObject) {
        self.DestinationName = data[PopularDestination.ParserKeys.name] as? String ?? ""
        self.VisitedNumber = data[PopularDestination.ParserKeys.visited] as? Int ?? 0
        self.FavoritedNumber = data[PopularDestination.ParserKeys.favorite] as? Int ?? 0
        self.Details = data[PopularDestination.ParserKeys.details] as? String ?? ""
        self.ImageURL = data[PopularDestination.ParserKeys.imageURL] as? String ?? ""
    }
}

extension PopularDestination {
    struct ParserKeys {
        static let favorite = "favorite"
        static let visited = "visited"
        static let name = "placeName"
        static let details = "placeDetails"
        static let imageURL = "imageURL"
    }
}

enum PopularPlaceType: String {
    case visited = "visited"
    case favorite = "favorite"
}
