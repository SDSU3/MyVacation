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
    @IBOutlet private var menuButtons: [UIButton]?
    @IBOutlet private weak var departureView: UIView!
    @IBOutlet private weak var arrivalView: UIView!
    
    //departure view
    @IBOutlet private weak var departureAirportLabel: UILabel!
    @IBOutlet private weak var fromPlaceLabel: UILabel!
    @IBOutlet private weak var startDateLabel: UILabel!
    
    //arrival view
    @IBOutlet private weak var arrivalAirportLabel: UILabel!
    @IBOutlet private weak var toPlaceLabel: UILabel!
    @IBOutlet private weak var endDateLabel: UILabel!
    
    var delegate: VacationDelegate?
    var vacation: Vacation?
    var weather: Weather?
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.setUpComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func initialize(){
        vacationNameLabel.text = vacation?.name
        //departure info
        departureAirportLabel.text = vacation?.departureAirport
        fromPlaceLabel.text = vacation?.fromPlace
        startDateLabel.text = vacation?.startDate.getFullDate()
        //arrival info
        arrivalAirportLabel.text = vacation?.arrivalAirport
        toPlaceLabel.text = vacation?.ToPlace
        endDateLabel.text = vacation?.endDate.getFullDate()
        loadWeather()
    }
    
    private func setUpComponents() {
        // weather collection view
        weatherCollectionView.registerCell(with: WeatherCell.self)
        // interesting places collection view
        interestingPlacesCollectionView.registerCell(with: InterestingPlaceCell.self)
        
        [weatherCollectionView, interestingPlacesCollectionView].forEach({ collecitonView in
            collecitonView?.delegate = self
            collecitonView?.dataSource = self
            collecitonView?.showsHorizontalScrollIndicator = false
            collecitonView?.backgroundColor = .clear
            
        })
        
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
        
        switch item {
        case .start:
            self.startVacation()
        case .edit:
            self.showAlert(with: "we are working on this feature please wait") {}
        case .map:
            self.showMap()
        case .delete:
            self.deleteVacation()
        case .none:
            print("none")
        }
    }
    
    private func loadWeather() {
        guard let lat = vacation?.position?.first, let lon = vacation?.position?.last else { return }
        APIServices.getWeather(lat: lat, lon: lon, completion: { [weak self] result in
            switch result {
            case .success(let weather):
                print(weather)
                self?.weather = weather
                DispatchQueue.main.async { [weak self] in
                    self?.weatherCollectionView.reloadData()
                }
            case .failure(_):
                self?.showAlert(with: "could not load weathers sorry") {}
            }
        })
    }
    
    private func startVacation() {
        guard let vacation = vacation else { return }
        if vacation.status == .active {
            self.showAlert(with: "You have already started this vacation") {}
        } else {
            vacation.status = .active
            UserServices.updateVacation(with: vacation, completion: { success in
                self.delegate?.didUpdateVacations(with: "Congratualtion! you have started your vacation")
            })
        }
    }
    
    private func showMap() {
        guard let vacation = vacation else { return }
        let map = MapViewController.load(vacations: [vacation], selectedVacation: true)
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    private func deleteVacation() {
        guard let vacation = vacation else { return }
        UserServices.deleteVacation(with: vacation, completion: { [weak self] success in
            self?.delegate?.didUpdateVacations(with: "Deleted vacation successfully")
        })
    }
    
    private func showAlert(with text: String, completion: @escaping ()-> Void){
        let alert = UIAlertController(title: "Update", message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            alert.dismiss(animated: true, completion: {
                completion()
            })
        })
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension VacationDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == weatherCollectionView {
            return weather?.daily?.data?.count ?? 0
        } else if collectionView == interestingPlacesCollectionView {
            return vacation?.interestingPlaces?.places?.count ?? 0
        }
        return 0
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
            if let weather = weather?.daily?.data?[indexPath.row] {
                cell.setUp(with: weather, day: indexPath.row)
            }
            return cell
            
        } else if collectionView == interestingPlacesCollectionView {
            let cell = interestingPlacesCollectionView.dequeReusableCell(with: InterestingPlaceCell.self, indexPath: indexPath)
            if let place = vacation?.interestingPlaces?.places?[indexPath.row] {
                cell.setUp(with: place)
            }
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
