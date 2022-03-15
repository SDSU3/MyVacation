//
//  WeatherCell.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

class WeatherCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
