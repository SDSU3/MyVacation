//
//  UIViewController+Extensions.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 10.03.22.
//

import UIKit

class MainViewController: UIViewController {
    public class func loadFromStoryboard() -> Self {
        let storyboardName = self.className.replacingOccurrences(of: "NavigationController", with: "")
                                            .replacingOccurrences(of: "ViewController", with: "")
                                            .replacingOccurrences(of: "Controller", with: "")
        return self.loadStoryboard(from: storyboardName)!
    }
    
    static func _load<T>(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> T? {
        return UIStoryboard(name: storyboard, bundle: bundle).instantiateInitialViewController() as? T
    }
    
    static func loadStoryboard(with id: String, from storyboard: String, for bundle: Bundle? = nil) -> Self?
    {
        return self._load(with: id, from: storyboard, for: bundle)
    }
    
    static func loadStoryboard(from storyboard: String, for bundle: Bundle? = nil) -> Self?
    {
        return self.loadStoryboard(with: self.className, from: storyboard, for: bundle)
    }
}

