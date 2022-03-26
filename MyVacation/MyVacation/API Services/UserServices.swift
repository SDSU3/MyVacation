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
    
    static func addPopularDestination(vacation: Vacation,completion: @escaping (Bool) -> Void){
        let popularPlaces = PFObject(className: "PopularDestinations")
        popularPlaces["placeName"] = vacation.ToPlace
        UserServices.loadPopularDestination { result in
            switch result {
            case .success(let destinations):
                if let _ = destinations.filter({ $0.DestinationName == vacation.name }).first {
                    print("such vacation already exists")
                    completion(false)
                } else {
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
            case .failure(_):
                completion(false)
            }
        }
    }
    
    static func updatePopularDestination(selectedVac: Vacation, type: PopularPlaceType ,completion: @escaping (Bool) -> Void){
        UserServices.loadPopularDestination { result in
            switch result {
            case .success(let destinations):
                if let similarDestinations = destinations.filter({ $0.DestinationName == selectedVac.name }).first {
                    self.updateDestination(selectedDest: similarDestinations,
                                           type: type,
                                           completion: { result in
                        completion(result)
                    })
                } else {
                    completion(false)
                }
            case .failure(_):
                completion(false)
            }
        }
    }
    
    static private func updateDestination(selectedDest: PopularDestination, type: PopularPlaceType, completion: @escaping (Bool) -> Void) {
        let query = PFQuery(className:"PopularDestinations")
        let id = selectedDest.destinationObj?.objectId ?? ""
        query.getObjectInBackground(withId: id, block: { (destination,error) in
            if error != nil {
                print(error ?? "error")
                completion(false)
            } else if let destination = destination {
                let incrementKey = type == .favorite ? "favorite" : "visited"
                destination.incrementKey(incrementKey)
                destination.saveInBackground()
                completion(true)
            }
        })
    }
    
    static func loadPopularDestination(completion: @escaping (Result<[PopularDestination],Error>) -> Void){
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
    
    static func updateVacation(with newVacation: Vacation, completion: @escaping (Bool) -> Void) {
        let query = PFQuery(className:"Vacation")
        let id = newVacation.vacationObj?.objectId ?? ""
        query.getObjectInBackground(withId: id, block: { (vacation,error) in
            if error != nil {
                print(error ?? "error")
                completion(false)
            } else if let vacation = vacation {
                let updatedVacation = Vacation.createVacationBody(newVacation: newVacation,
                                                                  existingVacation: vacation)
                updatedVacation.saveInBackground()
                completion(true)
            }
        })
    }
    
    static func deleteVacation(with vacation: Vacation, completion: @escaping (Bool) -> Void) {
        let query = PFQuery(className:"Vacation")
        let id = vacation.vacationObj?.objectId ?? ""
        query.whereKey("objectId", equalTo: id)
        query.findObjectsInBackground { vacations,error in
            if error != nil {
                print(error ?? "error")
                completion(false)
            } else if let vacations = vacations {
                for vacation in vacations {
                    vacation.deleteEventually()
                }
                completion(true)
            }
        }
    }
}


