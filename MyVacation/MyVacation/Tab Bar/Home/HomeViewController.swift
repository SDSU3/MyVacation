//
//  HomeViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 10.03.22.
//

import UIKit

class HomeViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    static func load(with input: String) -> HomeViewController {
       let viewController = HomeViewController.loadFromStoryboard()
       return viewController
    }

}
