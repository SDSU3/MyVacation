//
//  PopularVacationsViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//  Last update by Dhiaa Bantan on 3/19/22.
//

import UIKit
import DropDown

class PopularVacationsViewController: MainViewController {
    
    //MARK: - Outlets:
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var FilterButton: UIButton!
    @IBOutlet weak var DestinationsTableView: UITableView!
    @IBOutlet weak var MenuLocation: UIView!
    
    //MARK: - Drop Down Menu:
    
    let dropDown = DropDown()
    // Drop Down Menu Options:
    let FilterMenu = Constants.FilterMenu
    
    
    //MARK: - Inital Values:
    
    // Popular Destinations Array, initially empty, populated with data retrieved from database:
    var PopularDestinations: [PopularDestination] = [
        PopularDestination(DestinationName: "San Diego", VisitedNumber: 90063, FavoritedNumber: 1000000),
        PopularDestination(DestinationName: "Las Vegas", VisitedNumber: 799222, FavoritedNumber: 5000000),
        PopularDestination(DestinationName: "Los Angeles", VisitedNumber: 562873, FavoritedNumber: 28476873),
        PopularDestination(DestinationName: "Jeddah", VisitedNumber: 900, FavoritedNumber: 100),
        PopularDestination(DestinationName: "Paris", VisitedNumber: 400000000, FavoritedNumber: 3000000000),
        PopularDestination(DestinationName: "Fresno", VisitedNumber: 40, FavoritedNumber: 20),
        PopularDestination(DestinationName: "Baltimore", VisitedNumber: 100, FavoritedNumber: 80)
    ]
    
    // Popular Destinations Array, to filter the original array when using the search bar:
    var PopularDestinations_Search: [PopularDestination] = []
    
    //MARK: - View Did Load:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the tableview data source and delegate:
        DestinationsTableView.dataSource = self
        DestinationsTableView.delegate = self
        SearchBar.delegate = self
        
        // Initially assign Popular Destinations Array with the original values:
        PopularDestinations_Search = PopularDestinations.sorted {$0.DestinationName! < $1.DestinationName!}
        
        //MARK: - (AccountButton) Drop Down Menu Configuration:
        
        // The view to which the drop down will appear on
        dropDown.anchorView = MenuLocation;
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = FilterMenu
        
        // Make the Menu appears on the buttom
        dropDown.direction = .bottom
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            // If the selected option is "Visited":
            if(index == 0){
                // Sort the PopularDestinations Array (by name):
                PopularDestinations_Search.sort { $0.DestinationName! < $1.DestinationName! }
                
            } else if(index == 1){
                
                // Sort the PopularDestinations Array (top visited):
                PopularDestinations_Search.sort { $0.VisitedNumber! > $1.VisitedNumber! }
                
            } else if (index == 2){
                
                // Sort the PopularDestinations Array (top Favorited):
                PopularDestinations_Search.sort { $0.FavoritedNumber! > $1.FavoritedNumber! }
                
            }
            
            // Reload the table view:
            DestinationsTableView.reloadData()
            
        }
        
    }
    
    
    //MARK: - Filter Button:
    
    @IBAction func FilterButtonPressed(_ sender: UIButton) {
        // DropDown Menu appears:
        dropDown.show()
    }
    
    
    // MARK: - init
    static func load() -> PopularVacationsViewController {
        let viewController = PopularVacationsViewController.loadFromStoryboard()
        return viewController
    }
    
}


//MARK: - Table View Data Source:

extension PopularVacationsViewController: UITableViewDataSource {
    
    // Number of rows in the table view:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of the popular destenations array's items:
        return PopularDestinations_Search.count
    }
    
    // Cell Configuration:
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = DestinationsTableView.dequeueReusableCell(withIdentifier: Constants.DestinationCellID) as! DestinationCell
        
        cell.DestinationName.text = PopularDestinations_Search[indexPath.row].DestinationName
        cell.VisitedNumber.text = "\(PopularDestinations_Search[indexPath.row].VisitedNumber!)"
        cell.FavoritedNumber.text = "\(PopularDestinations_Search[indexPath.row].FavoritedNumber!)"
        
        return cell
    }
    
}

//MARK: - Table View Delegate:

extension PopularVacationsViewController: UITableViewDelegate {
    
    // When a row gets selected:
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Extract the selected destination's info:
        Constants.SelectedDestination = PopularDestinations_Search[indexPath.row]
        
        // Navigate to the selected destenation's Info screen:
        performSegue(withIdentifier: Constants.DestinationInfoSegue, sender: self)
        
    }
    
}

//MARK: - Search Bar Delegate:

extension PopularVacationsViewController: UISearchBarDelegate {
    
    // When Search Bar text changes:
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // When there is no text, PopularDestinations_Search is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the PopularDestinations array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included:
        
        PopularDestinations_Search = searchText.isEmpty ? PopularDestinations : PopularDestinations.filter({(data: PopularDestination) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return data.DestinationName?.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        // Reload the table view:
        DestinationsTableView.reloadData()
    }
}
