//
//  InterestingPlaceCell.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

class InterestingPlaceCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainConttentView: UIView!
    @IBOutlet private weak var placeImageView: UIImageView!
    @IBOutlet private weak var placeNameLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpComponents()
    }
    
    private func setUpComponents(){
        mainConttentView.roundCorners(with: 10)
        placeImageView.roundCorners(with: 10)
        mainConttentView.addShadow(of: .lightGray, radius: 2, offset: CGSize(width: 2, height: 2))
    }

}
