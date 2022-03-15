//
//  PlanViewController.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 14.03.22.
//

import UIKit

class PlanViewController: MainViewController {
    
    @IBOutlet weak var vacationNameTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var dataPicker: UIDatePicker!
    @IBOutlet weak var departureAirport: UICollectionView!
    @IBOutlet weak var arrivalAirport: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    static func load(with input: String) -> PlanViewController {
       let viewController = PlanViewController.loadFromStoryboard()
       return viewController
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
