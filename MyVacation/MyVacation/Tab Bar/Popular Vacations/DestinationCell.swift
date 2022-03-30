//
//  DestinationCell.swift
//  MyVacation
//
//  Created by Dhiaa Bantan on 3/19/22.
//

import UIKit

class DestinationCell: UITableViewCell {

    //MARK: - Outlets:
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var DestinationName: UILabel!
    @IBOutlet weak var VisitedNumber: UILabel!
    @IBOutlet weak var FavoritedNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.roundCorners(with: 10)
        mainView.addShadow(radius: 3, offset: CGSize(width: 2, height: 2))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
