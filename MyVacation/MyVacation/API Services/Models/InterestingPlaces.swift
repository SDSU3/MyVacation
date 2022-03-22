//
//  InterestingPlaces.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import UIKit

struct InterestingPlaces: Codable {
    var places: [InterestingPlace]?
    
    private enum CodingKeys: String, CodingKey {
        case places = "results"

    }
}

struct InterestingPlace: Codable {
    var category: String?
    var highlightedTitle: String?
    var position: [Double]?
    var title: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case category = "category"
        case highlightedTitle = "highlightedTitle"
        case position = "position"
        case title = "title"

    }
}

enum PlaceCategory: String {
    case museum = "museum"
    case hotel = "hotel"
    case restaurant = "restaurant"
    case coffeeTea = "coffee-tea"
    case cinema = "cinema"
    case unknown = "unknown"
    
    func getImage() -> UIImage {
        return UIImage.getImage(named: "\(self.rawValue)_icon")
    }
}
