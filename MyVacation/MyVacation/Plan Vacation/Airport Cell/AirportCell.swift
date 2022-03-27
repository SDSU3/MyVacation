//
//  AirportCell.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 27.03.22.
//

import UIKit

class AirportCell: UICollectionViewCell {
    @IBOutlet weak var airportName: UILabel!
    @IBOutlet weak var airportCode: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.roundCorners(with: 5)
        self.mainView.addShadow(radius: 3, offset: CGSize(width: 2, height: 2))
    }
    
}
