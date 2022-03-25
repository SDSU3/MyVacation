//
//  DestinationInfoViewController.swift
//  MyVacation
//
//  Created by Dhiaa Bantan on 3/19/22.
//

import UIKit

class DestinationInfoViewController: UIViewController {

    //MARK: - Outlets:
    @IBOutlet weak var DestinationImage: UIImageView!
    @IBOutlet weak var DestinationNameLabel: UILabel!
    @IBOutlet weak var VisitedNumberLabel: UILabel!
    @IBOutlet weak var FavoritedNumberLabel: UILabel!
    @IBOutlet weak var DestinationInfoLabel: UILabel!
    
    
    //MARK: - Initial Values:
    let SelectedDestination = Constants.SelectedDestination
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the destination info (retrieve data from API):
        DestinationNameLabel.text = SelectedDestination.DestinationName
        VisitedNumberLabel.text = "\(SelectedDestination.VisitedNumber)"
        FavoritedNumberLabel.text = "\(SelectedDestination.FavoritedNumber)"
        
    }
    

}
