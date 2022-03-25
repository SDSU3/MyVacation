//
//  TabBarController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {

    private var vacations: [Vacation]?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    // MARK: - load
    private func load(){
        loadVacations()
        self.selectedIndex = 0
        self.tabBar.backgroundColor = .white
        self.tabBar.roundCorners(with: 20)
    }
    
    private func loadVacations() {
        UserServices.loadVacations(completion: { [weak self] result in
            switch result {
            case .success(let vacations):
                self?.vacations = vacations
                self?.setUpTabBarControllers()
            case .failure(let err):
                print("error \(err)")
            }
        })
    }
    
    private func setUpTabBarControllers() {
        if let home = getController(with: HomeViewController.load(with: vacations), type: .Home),
           let map = getController(with: MapViewController.load(vacations: vacations), type: .Map),
           let popularVacations = getController(with: PopularVacationsViewController.load(), type: .PopularVacations),
           let settings = getController(with: SettingsViewController.load(), type: .Settings) {
            
           self.viewControllers = [home, map, popularVacations, settings]
        }
    }
    
    private func getController<T: UIViewController>(with controller: T?, type: TabBarItemType) -> UINavigationController? {
        guard let viewController = controller else { return nil }
        let navigationController = UINavigationController.init(rootViewController: viewController)
        let tabBarItem = UITabBarItem(title: "",
                                      image: UIImage(named: type.getImageName()),
                                      selectedImage: UIImage(named: type.getImageName()))
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}

// MARK: - TabBarItemType
enum TabBarItemType: Int {
    case Home
    case Map
    case PopularVacations
    case Settings
    
    var description: String {
        switch self {
        case .Home: return "Home"
        case .Map: return "Map"
        case .PopularVacations: return "PopularVacations"
        case .Settings: return "Settings"
        }
    }
    
    func getImageName() -> String {
        let imageName = self.description + "_icon"
        return imageName
    }
    
    func getControllerId() -> String {
        let controllerId = self.description + "ViewController"
        return controllerId
    }
}
