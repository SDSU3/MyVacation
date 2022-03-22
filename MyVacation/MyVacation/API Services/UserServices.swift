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
            } else {
                print("could not sign up \(error?.localizedDescription ?? "")")
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
    
    static func loadVacations(completion: @escaping ([Vacation]?) -> Void){
        let query = PFQuery(className: "Vacation")
        
        query.findObjectsInBackground { (result, error) in
            if let loadVacations = result {
                var vacations = [Vacation]()
                for vacation in loadVacations {
                    vacations.append(Vacation(with: vacation))
                }
                completion(vacations)
            } else {
                print("could not load posters \(error?.localizedDescription ?? "")")
                completion(nil)
            }
        }
    }
}


