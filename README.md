# MyVacation

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
As user will register in the app, the user will have the ability to choose the destination where the user wants to go. After that, MyVacation will show some recommended places where the user can go during the vacation, so all the vacation information will be sorted in an organized plan.

### App Evaluation
- **Category:** Travel.
- **Mobile:** This app would be primarily developed for mobile.
- **Story:** Help users planning for their vacation and how they want to spend it. Also, myVacation app can display the landmarks, things to do, must-popular restaurants. 
- **Market:** Any individual could choose to use myVacation, and to plan their vacation, vacations would be organized.
- **Habit:** This app could be used while planning traveling, and during the vacation.
- **Scope:** Everyone who want to travel.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* - [x] User can create an account. **(DONE)**
* - [x] User can log in. **(DONE)**
* - [x] User can plan how to spend a vacation. **(DONE)**
* - [x] User can set the places to be visited **(DONE)**
* - [X] User can add information of the visit, including the time and location. **(DONE)**
* - [x] User can set the duration of the vacation. **(DONE)**
* - [X] User can set the destination of the vacation. **(DONE)**
* - [x] User can view all his/her vacations **(DONE)** 

**Optional Nice-to-have Stories**

* - [ ] User can see the cost of the plan.
* - [x] User can see weather at the place where he\she plans to go **(DONE)**
* - [ ] User can add the flight information.
* - [x] User can view place on map. **(DONE)**

### 2. Screen Archetypes
* Login 
* Register (sign up)
   * the user should provide general information in order to register in the app, like: email, first name, last name, password.
   * after providing general information user can directly continue adding some vacation in his/her list
* vacations screen - list of vacations
   * user can select vacation from the list and get more detail information about the vacation, or he/she can add new vacation just by tapping button at the top right corner of the screen. 
* adding vacation
    * user shoudl provide where he/she wants to go and based on this information the app will show departure/arrival airports.
    * Also, user can add more details about his/her vacation by selecting some categories, like museums, interteiment centers, and etc. 
* Settings Screen
   * user will be able to change his/her time zone, applicaiton mode, some general information, and also could allow app to send notificaitons before starting one of his/her vacation.


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Vacations
* Map
* Popular Destinations
* Settings

**Flow Navigation** (Screen to Screen)

* sing up -> register user -> jump to the screen where he/she can add or manage vacations.
* Vacations -> vacation detail / vacation settings
* Add vacation -> Add interesting categories
* Map
* Popular destinations
* Settings -> update settings based on users will

## Wireframes
<img width="900" alt="Screenshot 2022-03-07 at 15 25 56" src="https://user-images.githubusercontent.com/55408144/157022638-cb91d10b-5421-496b-bc74-c4a2bd4bd84f.png">


### [BONUS] Digital Wireframes & Mockups
* Screens for Sign In / Sing Up  <br>
<img width="224" alt="Screenshot 2022-03-07 at 13 42 29" src="https://user-images.githubusercontent.com/55408144/157006941-6a56d5d3-d825-4ebb-a05f-8124f604031c.png"> --> <img width="224" alt="Screenshot 2022-03-07 at 13 42 37" src="https://user-images.githubusercontent.com/55408144/157006971-b7db2b74-5497-4151-b1b1-ab87c0939467.png"> <img width="224" alt="Screenshot 2022-03-07 at 13 42 42" src="https://user-images.githubusercontent.com/55408144/157006990-fe4bdd38-9364-4be1-93d1-1279c394d5bd.png">

* Add new vacation screen <br>
<img width="224" alt="Screenshot 2022-03-07 at 13 42 08" src="https://user-images.githubusercontent.com/55408144/157007008-f2a12f31-fdfc-4999-bab1-088c00553294.png"> <img width="224" alt="Screenshot 2022-03-07 at 13 42 20" src="https://user-images.githubusercontent.com/55408144/157007018-234c4a47-d19e-4cdc-bb8a-4ffcf534dd9b.png">

* Vacation list screen <br>
<img width="224" alt="Screenshot 2022-03-07 at 13 42 49" src="https://user-images.githubusercontent.com/55408144/157008632-a0f4f336-1225-483d-a00b-a665eb902d5f.png"> <img width="224" alt="Screenshot 2022-03-07 at 13 42 58" src="https://user-images.githubusercontent.com/55408144/157007104-ac86aa7d-8bec-4a39-8acf-e009b8e5cd07.png"> <img width="224" alt="Screenshot 2022-03-07 at 13 43 06" src="https://user-images.githubusercontent.com/55408144/157007126-4e526188-a018-468c-8ea3-a9a1df21a685.png">

* map screen <br>
<img width="224" alt="Screenshot 2022-03-07 at 13 43 19" src="https://user-images.githubusercontent.com/55408144/157007255-f4f50e9a-dd48-4cf6-803b-80e37752a628.png">

* Popular vacations screen <br>
<img width="224" alt="Screenshot 2022-03-07 at 13 43 25" src="https://user-images.githubusercontent.com/55408144/157007210-ef374c68-edd1-4833-97e0-5c697633c4b3.png"> <img width="224" alt="Screenshot 2022-03-07 at 13 43 29" src="https://user-images.githubusercontent.com/55408144/157007220-4d01740d-52e3-4b39-bd91-2950c021bd18.png"> 

* Settings screen <br>
<img width="224" alt="Screenshot 2022-03-07 at 13 43 38" src="https://user-images.githubusercontent.com/55408144/157007285-184b78dd-a3ac-47eb-9a26-2d1edefab372.png">

### [BONUS] Interactive Prototype
<img src="http://g.recordit.co/y7odzxjVUm.gif" width=250><br>

## Schema 
### Models
#### User Table:
<img src="https://i.ibb.co/4gj8mpV/User-Table.png" width=400><br>

#### Vacation Table:
<img src="https://i.ibb.co/1Qt18Bw/Vacation-Table.png" width=400><br>


### Networking
#### List of network requests by screen
   - Sign Up Screen
      - (Create/POST) Create new profile
         ```swift
         let user = PFUser()
        user.username = self.usernameField.text
        user.password = self.passwordField.text
        
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error)
            }
        }
         ```
   - Log In Screen
      - (Read/GET) Get the user
      ```swift
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                let alert = UIAlertController(title: "Wrong User", message: "Username and password did't match",         preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    //Cancel Action
                }))
                self.present(alert, animated: true, completion: nil)
                //self.alert(withTitle: "Error", message: error.localizedDescription)
                print(error)
            }
        }
         ```
   - Plan a vacation screen
      - (Create/POST) Create vacation
      - (Update/PUT) Update vacation
      - (Delete) Delete vacation

   - Vacation list screen
      - (Read/GET) Fetch vacation name
      - (Read/GET) Fetch vacation date

   - Popular vacation screen
      - (Read/GET) Fetch popular places
#### [OPTIONAL:] Existing API Endpoints

##### Airport API
- Base URL - [https://airlabs.co/api](https://airlabs.co/api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /v9/airports? | gets airpots with county code (2) ex: GE, US
    
##### Weather API
- Base URL - [https://api.darksky.net/forecast/](https://darksky.net/dev)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /forecast | gets weather for given lat / lon
    
##### Images API
- Base URL - [https://pixabay.com](https://pixabay.com/service/about/api/)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /?key=\(key)&q=\(name)&image_type=photo | returns images based on given name
    
##### Cities API
- Base URL - [https://api.api-ninjas.com](https://api.api-ninjas.com/)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /api/v1/city?name= | gets max 25 cities based on given name 
    
##### Places API
- Base URL - [https://places.ls.hereapi.com](https://developer.here.com/documentation/places/dev_guide/topics_api/resource-autosuggest.html)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /places/v1/autosuggest? | gets recommended places based on category, lat, lon

    
    
# App Progress
### Milestone 1
<img src="https://user-images.githubusercontent.com/55408144/158458498-977a03fb-3bec-4dd0-af81-6b55d8151433.gif" width=250><br>
### Milestone 2
<img src="https://user-images.githubusercontent.com/55408144/159588131-68845a41-5acf-45a0-b5a5-be167d2d470d.gif" width=250><br>
### Milestone 3
<img src="https://user-images.githubusercontent.com/55408144/160724601-fb306646-5c24-4a22-a451-e9b08d5d7281.gif" width=250><br>
