//
//  VacationCell.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit
import AlamofireImage

class VacationCell: UICollectionViewCell {

    // MARK: IBOutlets
    @IBOutlet private weak var mainContentView: UIView!
    @IBOutlet private weak var vacationImageView: UIImageView!
    @IBOutlet private weak var vacationNameLabel: UILabel!
    @IBOutlet private weak var vacationDateLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    
    // MARK: LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpComponents()
        self.contentView.backgroundColor = .clear
    }
    
    func setUp(with vacation: Vacation) {
        vacationNameLabel.text = vacation.name
        let startDate = vacation.startDate.getDayAndMonth()
        let endDate = vacation.endDate.getDayAndMonth()
        vacationDateLabel.text = "Date: \(startDate) - \(endDate)"
        statusLabel.text = vacation.status.rawValue
        statusLabel.textColor = vacation.status.getColor()
        if let imageUrl = URL(string: vacation.image ?? "") {
            vacationImageView.af.setImage(withURL: imageUrl)
        } else {
            vacationImageView.image = UIImage(named: "template_vacation_image")
        }
    }
    
    private func setUpComponents(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        mainContentView.roundCorners(with: 30)
        self.addShadow(of: .darkGray, radius: 5, offset: CGSize(width: 4, height: 4))
        
    }
}
