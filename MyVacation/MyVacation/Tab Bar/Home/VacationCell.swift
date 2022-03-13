//
//  VacationCell.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

class VacationCell: UICollectionViewCell {

    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var vacationImageView: UIImageView!
    @IBOutlet weak var vacationNameLabel: UILabel!
    @IBOutlet weak var vacationDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //shadow
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        
        //round main view
        mainContentView.clipsToBounds = true
        mainContentView.layer.cornerRadius = 30
        contentView.backgroundColor = .clear
        
        //round add vacation button
        
    }

}
