//
//  UIImage+Extension.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit

extension UIImage {
    static func getImage(named: String ) -> UIImage {
        return UIImage(named: named) ?? UIImage(named: "empty_icon")!
    }
}
