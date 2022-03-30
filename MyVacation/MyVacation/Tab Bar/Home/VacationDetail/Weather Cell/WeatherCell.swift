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
    
    func setUp(with weather: DailyWeatherEntry, day: Int) {
        guard let icon = weather.icon else { return }
        weatherImageView.image = UIImage.getImage(named: icon)
        if let intTime = weather.time {
            dayLabel.text = Date.intToDate(intTime).getDayAndMonth()
        } else {
            dayLabel.text = "day \(day + 1)"
        }
    }
}


