//
//  APIServices.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 20.03.22.
//

import Foundation
import UIKit

class APIServices {
    
    static func getURL<T: Codable>(with url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
    static func getURLRequest<T: Codable>(with url: URLRequest, completion: @escaping (Result<T,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
//    static func getPlace(name: String, completion: @escaping (Result<Place,Error>) -> Void){
//        let baseURL = "http://api.opentripmap.com/0.1/en/places/geoname"
//        guard let url = URL(string: "\(baseURL)?name=\(name)&apikey=\(APIServices.openTripApiKey)") else { return }
//        getURL(with: url, completion: { result in
//            completion(result)
//        })
//    }
    
    //https://places.ls.hereapi.com/places/v1/autosuggest?at=41.716667,44.783333&q=cinema&apiKey=rq8ZtqKUTIbQ_H-O8iAgcwoY6EyCxB5eM7ftxJjwC_o
    
    static func getPlace(category: PlaceCategory, lat: Double, lon: Double, completion: @escaping (Result<InterestingPlaces,Error>) -> Void){
        let baseURL = "https://places.ls.hereapi.com/places/v1/autosuggest?"
        let key = "rq8ZtqKUTIbQ_H-O8iAgcwoY6EyCxB5eM7ftxJjwC_o"
        guard let url = URL(string: "\(baseURL)at=\(lat),\(lon)&q=\(category.rawValue)&apiKey=\(key)") else { return }
        getURL(with: url, completion: { result in
            completion(result)
        })
    }
    
    
    // gets max 25 cities based on given name
    static func getCities(name: String, completion: @escaping (Result<[Place],Error>) -> Void){
        let key = "Z7N68HLrwh65gQLZoCCKRg==R8o6byFG2aANS9vy"
        let baseURL = "https://api.api-ninjas.com/v1/city?name="
        guard let url = URL(string: "\(baseURL)\(name)&limit=25") else { return }
        var request = URLRequest(url: url)
        request.setValue(key, forHTTPHeaderField: "X-Api-Key")
        getURLRequest(with: request, completion: { result in
            completion(result)
        })
    }
    
    // gets airpots with county code (2) ex: GE, US
    static func getAiports(countryCode: String, completion: @escaping (Result<Airpots,Error>) -> Void){
        let key = "ca276273-25ae-4a59-9d90-c975880ac205"
        let baseURL = "https://airlabs.co/api/v9/airports?"
        guard let url = URL(string: "\(baseURL)country_code=\(countryCode)&api_key=\(key)") else { return }
        getURL(with: url, completion: { result in
            completion(result)
        })
    }
    
    static func getDD(url: URL, completion: @escaping (Result<Void,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let err = err {
                completion(.failure(err))
            }
            
            guard let data = data else { return }
            do {
                let dataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                completion(.success(()))
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
    
}

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




