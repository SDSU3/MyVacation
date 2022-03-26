//
//  Images.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 26.03.22.
//

import Foundation

struct Images: Codable {
    var images: [Image]?
    
    private enum CodingKeys: String, CodingKey {
        case images = "hits"
    }
}

struct Image: Codable {
    var name: String?
    var smallUrl: String?
    var largeUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "tags"
        case smallUrl = "previewURL"
        case largeUrl = "largeImageURL"
    }
}

