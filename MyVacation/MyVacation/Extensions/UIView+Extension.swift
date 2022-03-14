//
//  UIView+Extension.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

// MARK: - shadows
extension UIView {
    enum LayersName: String {
        case shadow = "shadow"
    }
    
    func removeLayer(of type: LayersName) {
        guard let layers = self.layer.sublayers else { return }
        for layer in layers {
            if let name = layer.name, name == type.rawValue {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func addShadow(of color: UIColor = .darkGray, radius: CGFloat, offset: CGSize = .zero, opacity: Float = 1) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.name = LayersName.shadow.rawValue
    }
}

// MARK: - round Corners
extension UIView {
    
    func roundCorners(with radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
}

// MARK: - Gradient layer extension
extension UIView {
    func LinearbackgroundColor(with colors: [UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}
