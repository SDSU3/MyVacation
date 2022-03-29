//
//  PlacesViewController.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 15.03.22.
//

import UIKit

class PlacesViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var placesTableView: UITableView!
    
    var chosenCity: Place?
    var interestingPlaces: InterestingPlaces?
    var placesOption: [InterestingPlace] = []
    var chosenPlaces: [InterestingPlace] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaces(category: .museum)
        setUpUserMenu()
        placesTableView.dataSource = self
        placesTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func getPlaces(category: PlaceCategory) {
        APIServices.getPlace(category: category, lat: (self.chosenCity?.lat)!, lon: (self.chosenCity?.lon)!, completion: { result in
            switch result {
            case .success(let places):
                for place in places.places! {
                    self.placesOption.append(place)
                }
                DispatchQueue.main.async {
                    self.placesTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
        
    }
    

    
    
    private func setUpUserMenu() {
        filterButton.showsMenuAsPrimaryAction = true
        let items = UIMenu(title: "more", options: .displayInline, children: [
            UIAction(title: PlaceCategory.museum.rawValue, handler: {_ in self.filterClicked(.museum)}),
            UIAction(title: PlaceCategory.hotel.rawValue, handler: {_ in self.filterClicked(.hotel)}),
            UIAction(title: PlaceCategory.restaurant.rawValue, handler: {_ in self.filterClicked(.restaurant)}),
            UIAction(title: PlaceCategory.coffeeTea.rawValue, handler: {_ in self.filterClicked(.coffeeTea)}),
            UIAction(title: PlaceCategory.cinema.rawValue, handler: {_ in self.filterClicked(.cinema)}),
            UIAction(title: PlaceCategory.unknown.rawValue, handler: {_ in self.filterClicked(.unknown)})
        ])
        let menu = UIMenu(title: "", children: [items])
        filterButton.menu = menu
    }
    
    private func filterClicked(_ name: FilterOptions) {
        placesOption.removeAll()
        switch name {
        case .museum:
            getPlaces(category: .museum)
        case .hotel:
            getPlaces(category: .hotel)
        case .restaurant:
            getPlaces(category: .restaurant)
        case .coffeeTea:
            getPlaces(category: .coffeeTea)
        case .cinema:
            getPlaces(category: .cinema)
        case .unknown:
            getPlaces(category: .unknown)
        }
        placesTableView.reloadData()
    }
    
    enum FilterOptions: String {
        case museum = "museum"
        case hotel = "hotel"
        case restaurant = "restaurant"
        case coffeeTea = "coffee-tea"
        case cinema = "cinema"
        case unknown = "unknown"
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
    }
    
    

}

extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
        cell.placeName.text = placesOption[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenPlaces.append(placesOption[indexPath.row])
        placesTableView.cellForRow(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.2766574323, green: 0.2132521868, blue: 0.6103910804, alpha: 1)
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        placesTableView.cellForRow(at: indexPath)?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    }
    
}

