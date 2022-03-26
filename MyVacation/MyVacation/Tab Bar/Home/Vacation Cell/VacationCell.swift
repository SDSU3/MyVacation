//
//  VacationCell.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

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
    }
    
    private func setUpComponents(){
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        mainContentView.roundCorners(with: 30)
        self.addShadow(of: .darkGray, radius: 5, offset: CGSize(width: 4, height: 4))
        
    }
}
