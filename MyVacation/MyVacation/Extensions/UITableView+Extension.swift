//
//  UITableView+Extension.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(with type: T.Type) {
        let nib = UINib(nibName: T.className, bundle: nil)
        register(nib, forCellReuseIdentifier: T.className)
    }
    
    func dequeReusableCell<T: UITableViewCell>(with type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("could not load cell \(T.className)")
        }
    }
}
