//
//  UserServices.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 21.03.22.
//

import Foundation
import Parse

class UserServices {

    static func signUp(username: String, password: String, email: String, completion: @escaping (Bool) -> Void) {
        let user = PFUser(className: "_User")
        user.username = username
        user.password = password
        user.email = email
        user.signUpInBackground { (success, error) in
            if success {
                print("saved user")
                completion(true)
            } else {
                print("could not sign up \(error?.localizedDescription ?? "")")
                completion(false)
            }
        }
    }
    
    static func signIn(username: String, password: String, completion: @escaping (Bool) -> Void) {
        PFUser.logInWithUsername(inBackground: username, password: password) {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
              completion(true)
              print("log in succesfully")
          } else {
              completion(false)
              print("could not sign in \(error?.localizedDescription ?? "")")
          }
        }
    }
    
    static func createVacation(with newVacation: Vacation, completion: @escaping (Bool) -> Void){
        let vacation = Vacation.createVacationBody(newVacation: newVacation)
        
        vacation.saveInBackground { (success,error) in
            if success {
                completion(true)
                print("saved new vacation")
            } else {
                completion(false)
                print("could not saved - error \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    static func loadVacations(completion: @escaping (Result<[Vacation]?,Error>) -> Void){
        let query = PFQuery(className: "Vacation")
        query.includeKeys(["author", "InterestingPlaces", "InterestingPlaces.author"])
        query.findObjectsInBackground { (result, error) in
            if let loadVacations = result {
                var vacations = [Vacation]()
                for vacation in loadVacations {
                    vacations.append(Vacation(with: vacation))
                }
                completion(.success(vacations))
            } else {
                print("could not load vacations \(error?.localizedDescription ?? "")")
                completion(.failure(error!))
            }
        }
    }
    
    static func addPlaces(with vacation: PFObject, places: InterestingPlaces, completion: @escaping (Bool) -> Void) {
        completion(false)
        
        var newPlaces: [PFObject] = []
        guard let interestingPlaces = places.places else {
            completion(false)
            return
        }
        
        interestingPlaces.forEach({ item in
            let place = InterestingPlace.createPlaceBody(newPlace: item)
            newPlaces.append(place)
        })
        vacation["InterestingPlaces"] = newPlaces
        vacation.saveInBackground { (success, error) in
            if success {
                print("saved places")
                completion(true)
            } else {
                print("could not add places")
                completion(false)
            }
        }
    }
    
    static func addPopularDestination(vacation: Vacation, type: PopularPlaceType ,completion: @escaping (Bool) -> Void){
        let popularPlaces = PFObject(className: "PopularDestinations")
        popularPlaces["placeName"] = vacation.ToPlace
        
        let incrementKey = type == .favorite ? "favorite" : "visited"
        popularPlaces.incrementKey(incrementKey)
        
        popularPlaces.saveInBackground { (success, error) in
            if success {
                print("saved places")
                completion(true)
            } else {
                print("could not add popular places \(error?.localizedDescription ?? "")")
                completion(false)
            }
        }
    }
    
    static func loadPopularDestination(vacation: Vacation, type: PopularPlaceType ,completion: @escaping (Result<[PopularDestination],Error>) -> Void){
        let query = PFQuery(className: "PopularDestinations")

        query.findObjectsInBackground { (result, error) in
            if let loadplaces = result {
                var places = [PopularDestination]()
                for place in loadplaces {
                    places.append(PopularDestination(with: place))
                }
                completion(.success(places))
            } else {
                print("could not load popular destinations \(error?.localizedDescription ?? "")")
                completion(.failure(error!))
            }
        }
    }
}


