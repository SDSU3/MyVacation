//
//  InterestingPlaces.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import UIKit
import Parse

struct InterestingPlaces: Codable {
    var places: [InterestingPlace]?
    
    private enum CodingKeys: String, CodingKey {
        case places = "results"

    }
}

struct InterestingPlace: Codable {
    var category: String?
    var highLightedTitle: String?
    var position: [Double]?
    var title: String?
    
    init(category: String, highLightedTitle: String, position: [Double], title: String) {
        self.category = category
        self.highLightedTitle = highLightedTitle
        self.position = position
        self.title = title
    }
    
    init(with data: PFObject) {
        category = data[InterestingPlace.ParserKeys.category] as? String ?? ""
        highLightedTitle = data[InterestingPlace.ParserKeys.highLightedTitle] as? String ?? ""
        position = data[InterestingPlace.ParserKeys.position] as? [Double] ?? []
        title = data[InterestingPlace.ParserKeys.title] as? String ?? ""
    }
    
    static func createPlaceBody(newPlace: InterestingPlace) -> PFObject {
        let place = PFObject(className: "InterestingPlaces")
        place[InterestingPlace.ParserKeys.author] = PFUser.current()
        place[InterestingPlace.ParserKeys.category] = newPlace.category ?? ""
        place[InterestingPlace.ParserKeys.highLightedTitle] = newPlace.highLightedTitle ?? ""
        place[InterestingPlace.ParserKeys.position] = newPlace.position ?? []
        place[InterestingPlace.ParserKeys.title] = newPlace.title ?? ""
        return place
    }
}

extension InterestingPlace {
    struct ParserKeys {
        static let author = "author"
        static let category = "category"
        static let highLightedTitle = "highlightedTitle"
        static let position = "placePosition"
        static let title = "title"
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
