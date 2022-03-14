//
//  VacationDetailsViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 14.03.22.
//

import UIKit

class VacationDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var VacationImageView: UIImageView!
    @IBOutlet private weak var vacationNameLabel: UILabel!
    @IBOutlet private weak var weatherCollectionView: UICollectionView!
    @IBOutlet private weak var interestingPlacesCollectionView: UICollectionView!
    @IBOutlet var menuButtons: [UIButton]?
    @IBOutlet weak var departureView: UIView!
    @IBOutlet weak var arrivalView: UIView!
    
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpComponents()
    }
    
    private func setUpComponents() {
        // weather collection view
        weatherCollectionView.registerCell(with: WeatherCell.self)
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.showsHorizontalScrollIndicator = false
        
        
        // interesting places collection view
        interestingPlacesCollectionView.registerCell(with: InterestingPlaceCell.self)
        interestingPlacesCollectionView.delegate = self
        interestingPlacesCollectionView.dataSource = self
        interestingPlacesCollectionView.showsHorizontalScrollIndicator = false
        
        menuButtons?.forEach({ button in
            guard let image = MenuItem(rawValue: button.tag)?.getImage() else { return }
            button.setImage(image, for: .normal)
            button.setTitle("", for: .normal)
            button.backgroundColor = .clear
            button.addShadow(radius: 3)
        })
        
        [departureView,arrivalView].forEach({ view in
            view?.roundCorners(with: 10)
            view?.addShadow(of: .lightGray, radius: 3, offset: CGSize(width: 2, height: 2))
        })
        
        VacationImageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        VacationImageView.roundCorners(with: 15)
    }
    
    @IBAction func menuButtonClicked(_ sender: UIButton) {
        let item = MenuItem(rawValue: sender.tag) ?? .none
        print("clicked: " + item.description())
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension VacationDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == weatherCollectionView {
            let size = weatherCollectionView.bounds.height - 10.0
            return CGSize(width: size, height: size)
            
        } else if collectionView == interestingPlacesCollectionView {
            let height = interestingPlacesCollectionView.bounds.height - 10.0
            let width = height * 2
            return CGSize(width: width, height: height)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weatherCollectionView {
            let cell = weatherCollectionView.dequeReusableCell(with: WeatherCell.self, indexPath: indexPath)
            return cell
            
        } else if collectionView == interestingPlacesCollectionView {
            let cell = interestingPlacesCollectionView.dequeReusableCell(with: InterestingPlaceCell.self, indexPath: indexPath)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
}

// MARK: - MenuItem
extension VacationDetailsViewController {
    enum MenuItem: Int {
        case start = 1
        case edit
        case map
        case delete
        case none
        
        func description() -> String {
            switch self {
            case .start:
                return "start"
            case .edit:
                return "edit"
            case .map:
                return "map"
            case .delete:
                return "delete"
            default:
                return "none"
            }
        }
        
        func getImage() -> UIImage {
            let imageName = self.description() + "_icon"
            return UIImage.getImage(named: imageName)
        }
    }
}
