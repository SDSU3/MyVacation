//
//  UICollectionView+ Extension.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(with type: T.Type) {
        let nib = UINib(nibName: T.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.className)
    }
    
    func dequeReusableCell<T: UICollectionViewCell>(with type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("could not load cell \(T.className)")
        }
    }
}

