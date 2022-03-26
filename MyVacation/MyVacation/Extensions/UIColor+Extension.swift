//
//  UIColor+Extension.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 25.03.22.
//

import UIKit

extension UIColor {
    convenience init(hexValue: Int, alpha: CGFloat = 1.0) {
        let red = hexValue >> 16
        let green = hexValue >> 8
        let blue = hexValue
        self.init(red: red & 0xff, green: green & 0xff, blue: blue & 0xff, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let red = red < 0 ? 0 : red > 255 ? 255 : red
        let green = green < 0 ? 0 : green > 255 ? 255 : green
        let blue = blue < 0 ? 0 : blue > 255 ? 255 : blue
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }
}
