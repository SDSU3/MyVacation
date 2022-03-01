Original App Design Project - README Template
===

# myVacation

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
As user will register in the app he/she will have the chance to choose the destination where he/she wants to go. After that, myVacation will show some recommended places where user can go during his/her vacation and sorted in an organized plan.

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

* User can create an account.
* User can log in.
* User can plan how to spend a vacation.
* User can set the places to be visited
* User can add information of the visit, including the time and location.
* User can set the duration of the vacation.
* User can set the destination of the vacation.

**Optional Nice-to-have Stories**

* User can see the cost of the plan.
* User can add the flight information.
* User can view place on map.

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
* Settings

Optional:
* Map
* list of popular vacations

**Flow Navigation** (Screen to Screen)

* sing up -> register user -> jump to the screen where he/she can add or manage vacations.
* Vacations -> vacation detail / vacation settings
* Add vacation -> Add interesting categories
* Settings -> update settings based on users will

## Wireframes
<img width="319" alt="Screenshot 2022-03-02 at 02 54 57" src="https://user-images.githubusercontent.com/55408144/156262717-2b1b07f4-44bb-4c05-aaed-8d61ca9e0db1.png">


### [BONUS] Digital Wireframes & Mockups
* Screens for Sign In / Sing Up 

    <img width="200" alt="Screenshot 2022-03-02 at 01 45 12" src="https://user-images.githubusercontent.com/55408144/156254417-14586ded-b11b-4805-8eb3-195fe2dd8e74.png"> <img width="200" alt="Screenshot 2022-03-02 at 01 45 17" src="https://user-images.githubusercontent.com/55408144/156254461-3fc31c5e-f659-4d0c-a84d-6fddf61c1b8a.png"> <img width="200" alt="Screenshot 2022-03-02 at 01 45 25" src="https://user-images.githubusercontent.com/55408144/156254734-777a40e4-acbd-4355-8970-868f8fd17d99.png"> <img width="200" alt="Screenshot 2022-03-02 at 01 45 30" src="https://user-images.githubusercontent.com/55408144/156254776-e120b03d-d41c-475e-b868-07fe6e8b2a1a.png">

   * Vacation list screen
   <img width="200" alt="Screenshot 2022-03-02 at 01 45 36" src="https://user-images.githubusercontent.com/55408144/156254836-82ab0083-f4eb-4168-8754-b9ed528bbfef.png">

### [BONUS] Interactive Prototype
<img src="http://g.recordit.co/y7odzxjVUm.gif" width=250><br>

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
