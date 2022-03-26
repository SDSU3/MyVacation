//
//  APIServices.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 20.03.22.
//

import UIKit

class APIServices {
    // generic method for getting result from given input URL
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
    
    // generic method for getting URL request from given input URLRequest
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
    
    // some general method that I use only for testing purpose to understand
    // what the hack is comming from request (just for testing purpose)
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
    
    // gets recommended places based on category, lat, lon
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

    // gets weather
    static func getWeather(lat: Double, lon: Double, completion: @escaping (Result<Weather,Error>) -> Void){
        let baseURL = "https://api.darksky.net/forecast/ddcc4ebb2a7c9930b90d9e59bda0ba7a/"
        guard let url = URL(string: "\(baseURL)\(41.716667),\(44.783333)?exclude=[flags,minutely]") else { return }
        getURL(with: url, completion: { result in
            completion(result)
        })
    }
    
    static func getImage(of name: String, completion: @escaping (Result<Images,Error>) -> Void){
        let baseURL = "https://pixabay.com/api/"
        let key = "26329382-429cd0fb9914fc0eba7b3a127"
        guard let url = URL(string: "\(baseURL)?key=\(key)&q=\(name)&image_type=photo") else { return }
        APIServices.getURL(with: url, completion: { result in
            completion(result)
            
        })
    }
}

