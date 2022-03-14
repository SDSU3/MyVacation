//
//  InterestingPlaceCell.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

class InterestingPlaceCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var mainConttentView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpComponents()
    }
    
    private func setUpComponents(){
        mainConttentView.roundCorners(with: 10)
        placeImageView.roundCorners(with: 10)
        mainConttentView.addShadow(of: .gray, radius: 2, offset: CGSize(width: 2, height: 2))
    }

}
