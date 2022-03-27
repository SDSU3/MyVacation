//
//  PopularVacationsViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//  Last update by Dhiaa Bantan on 3/19/22.
//

import UIKit
import Parse

class PopularVacationsViewController: MainViewController {
    
    //MARK: - Outlets:
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var FilterButton: UIButton!
    @IBOutlet weak var DestinationsTableView: UITableView!
    @IBOutlet weak var MenuLocation: UIView!
    
    //MARK: - Inital Values:
    
    // Popular Destinations Array, initially empty, populated with data retrieved from database:
    var PopularDestinations: [PopularDestination] = []
    
    // Popular Destinations Array, to filter the original array when using the search bar:
    var PopularDestinations_Search: [PopularDestination] = []
    
    //MARK: - View Did Load:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the tableview data source and delegate:
        DestinationsTableView.dataSource = self
        DestinationsTableView.delegate = self
        SearchBar.delegate = self
        setUpUserMenu()
        
        
        // Retrieve popular destinations from database:
        let query = PFQuery(className: "PopularDestinations")
        query.findObjectsInBackground(block: { objects, error in
            
            if error == nil {
                if let retrievedObjects = objects {
                    
                    for object in retrievedObjects {
                        self.PopularDestinations_Search.append(PopularDestination(with: object))
                        self.PopularDestinations.append(PopularDestination(with: object))
                        
                    }
                    self.DestinationsTableView.reloadData()
                    
                }
            }
            
        })
        
        // Initially assign Popular Destinations Array with the original values:
        PopularDestinations_Search = PopularDestinations.sorted {$0.DestinationName < $1.DestinationName}
    }
    
    
    private func setUpUserMenu() {
        FilterButton.showsMenuAsPrimaryAction = true
        let items = UIMenu(title: "more", options: .displayInline, children: [
            UIAction(title: "Name", handler: {_ in self.filterClicked(.name)}),
            UIAction(title: "Visited", handler: {_ in self.filterClicked(.visited)}),
            UIAction(title: "Favorite", handler: {_ in self.filterClicked(.favorite)})
        ])
        let menu = UIMenu(title: "", children: [items])
        FilterButton.menu = menu
    }
    
    private func filterClicked(_ name: FilterOptions) {
        switch name {
        case .name:
            PopularDestinations_Search.sort { $0.DestinationName < $1.DestinationName }
        case .favorite:
            PopularDestinations_Search.sort { $0.FavoritedNumber > $1.FavoritedNumber }
        case .visited:
            PopularDestinations_Search.sort { $0.VisitedNumber > $1.VisitedNumber }
        }
        DestinationsTableView.reloadData()
    }
    
    enum FilterOptions: String {
        case name = "name"
        case favorite = "favorite"
        case visited = "visited"
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
        cell.VisitedNumber.text = "\(PopularDestinations_Search[indexPath.row].VisitedNumber)"
        cell.FavoritedNumber.text = "\(PopularDestinations_Search[indexPath.row].FavoritedNumber)"
        
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
            return data.DestinationName.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        // Reload the table view:
        DestinationsTableView.reloadData()
    }
}

