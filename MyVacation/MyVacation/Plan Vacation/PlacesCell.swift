//
//  PlacesCell.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 29.03.22.
//

import UIKit

class PlacesCell: UITableViewCell {

    @IBOutlet weak var placeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.roundCorners(with: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
