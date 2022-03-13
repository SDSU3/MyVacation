//
//  SignInViewController.swift
//  MyVacation
//
//  Created by Dhiaa Bantan on 3/12/22.
//

import UIKit

class SignInViewController: MainViewController {
    
    @IBOutlet weak var SignInUpSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Sign In Screen did load")
    }
    
    
    static func load(with input: String) -> SignInViewController {
        let viewController = SignInViewController.loadFromStoryboard()
        return viewController
    }
    
    
    
}
