//
//  PlacesViewController.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 15.03.22.
//

import UIKit
import Parse

class PlacesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var filterButton: UIButton!
    @IBOutlet private weak var menu: UIView!
    @IBOutlet private weak var placesTableView: UITableView!
    
    // properties
    var vacation: Vacation?
    var delegate: PlanVacationDelegate?
    private var placesOption: [InterestingPlace] = []
    private var chosenPlaces: [InterestingPlace] = []
    private let categories: [PlaceCategory] = [.museum, .hotel, .restaurant, .coffeeTea, .cinema]

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlaces(category: .museum)
        setUpUserMenu()
        placesTableView.dataSource = self
        placesTableView.delegate = self
    }
    
    func getPlaces(category: PlaceCategory) {
        guard let vacation = vacation else { return }
        APIServices.getPlace(category: category,
                             lat: (vacation.position?.first)!,
                             lon: (vacation.position?.last)!,
                             completion: { [weak self] result in
            switch result {
            case .success(let places):
                for place in places.places! {
                    self?.placesOption.append(place)
                }
                DispatchQueue.main.async {
                    self?.placesTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }

    private func setUpUserMenu() {
        filterButton.showsMenuAsPrimaryAction = true
        let actionItems = categories.map({ category in
            UIAction(title: category.rawValue, handler: {_ in self.getPlaces(category: category)})
        })
        let items = UIMenu(title: "more", options: .displayInline, children: actionItems)
        let menu = UIMenu(title: "", children: [items])
        filterButton.menu = menu
    }
    
    // save vacation clicked
    @IBAction func saveButton(_ sender: UIButton) {
        saveVacation()
    }
    
    // save vacation in back end
    private func saveVacation() {
        guard let vacation = vacation else { return }
        var interestingPlaces = InterestingPlaces()
        interestingPlaces.places = chosenPlaces
        vacation.interestingPlaces = interestingPlaces
        UserServices.createVacation(with: vacation, completion: { [weak self] success in
            if success {
                self?.loadVacations()
            } else {
                self?.delegate?.createdVacation(with: "Unfortunatly there was some error. please try later")
            }
        })
    }
    
    // load vacations from back end
    private func loadVacations() {
        UserServices.loadVacations(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let vacations):
                guard let vacations = vacations else { return }
                let currentVacation = vacations.filter({ $0.name == self.vacation?.name && $0.ToPlace == self.vacation?.ToPlace }).first
                guard let vacationObj = currentVacation?.vacationObj else { return }
                self.savePlaces(with: vacationObj)
            case .failure(_):
                self.delegate?.createdVacation(with: "Unfortunatly there was some error. please try later")
            }
        })
    }
    
    // save places in vacation
    private func savePlaces(with obj: PFObject) {
        var places = InterestingPlaces()
        places.places = chosenPlaces
        UserServices.addPlaces(with: obj, places: places, completion: { [weak self] success in
            self?.delegate?.createdVacation(with: "Congretulation! you have created new vacation")
            if success {
                self?.delegate?.createdVacation(with: "Congretulation! you have created new vacation")
            } else {
                self?.delegate?.createdVacation(with: "Unfortunatly there was some error. please try later")
            }
        })
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension PlacesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placesTableView.dequeueReusableCell(withIdentifier: "PlacesCell", for: indexPath) as! PlacesCell
        let place = placesOption[indexPath.row]
        cell.placeName.text = place.title
        cell.selectionStyle = .none
        let containtsPlace = chosenPlaces.contains(where: { $0.title == place.title })
        cell.backgroundColor = containtsPlace ? #colorLiteral(red: 0.2766574323, green: 0.2132521868, blue: 0.6103910804, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.placeName.textColor = containtsPlace ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = placesOption[indexPath.row]
        if !chosenPlaces.contains(where: { $0.title == place.title }) {
            chosenPlaces.append(placesOption[indexPath.row])
        } else {
            chosenPlaces.removeAll(where: { $0.title == place.title })
        }
        tableView.reloadData()
    }
}

