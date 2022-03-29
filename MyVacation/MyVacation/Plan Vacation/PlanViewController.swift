//
//  PlanViewController.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 14.03.22.
//

import UIKit
import Koyomi
import iOSDropDown

class PlanViewController: MainViewController {
    //variables
    var citiesStringFrom = [String]()
    var citiesStringTo = [String]()
    var fromCity: String = ""
    var toCity: String = ""
    var countryCodeFrom: String = ""
    var countryCodeTo: String = ""
    var departureAirports = [String]()
    var arrivalAirports = [String]()
    var chosenDepartureAirport: String = ""
    var chosenArrivalAirport: String = ""
    fileprivate let invalidPeriodLength = 90
    var VacDates = VacationDates()
    var toCityLon: Double?
    var toCityLat: Double?
    var chosenCity: Place?
    
    
    //DropDown
    @IBOutlet weak var dropDownFrom: DropDown!
    @IBOutlet weak var dropDownTo: DropDown!
    
    //IBOutlets
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var vacationNameTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var departureAirport: UICollectionView!
    @IBOutlet weak var arrivalAirport: UICollectionView!
    @IBOutlet fileprivate weak var koyomi: Koyomi! {
        didSet {
            koyomi.circularViewDiameter = 0.2
            koyomi.calendarDelegate = self
            koyomi.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            koyomi.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
            koyomi.style = .standard
            koyomi.dayPosition = .center
            koyomi.selectionMode = .sequence(style: .semicircleEdge)
            koyomi.selectedStyleColor = UIColor(red: 203/255, green: 119/255, blue: 223/255, alpha: 1)
            koyomi
                .setDayFont(size: 14)
                .setWeekFont(size: 10)
        }
    }
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet fileprivate weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.setTitle("Previous", forSegmentAt: 0)
            segmentedControl.setTitle("Current", forSegmentAt: 1)
            segmentedControl.setTitle("Next", forSegmentAt: 2)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentDateLabel.text = ""
        
        [departureAirport, arrivalAirport].forEach({ airport in
            airport?.delegate = self
            airport?.dataSource = self
            airport?.registerCell(with: AirportCell.self)
            airport?.showsHorizontalScrollIndicator = false
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    static func load(with input: String) -> PlanViewController {
       let viewController = PlanViewController.loadFromStoryboard()
       return viewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaces" {
            if let viewController = segue.destination as? PlacesViewController {
                viewController.chosenCity = chosenCity
            }
        }
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        checkFields()
        self.performSegue(withIdentifier: "toPlaces", sender: nil)
        guard let startDate = VacDates.startDate?.addingTimeInterval(60 * 60 * 24),
              let endDate = VacDates.endDate?.addingTimeInterval(60 * 60 * 24) else { return }
        let vacation = Vacation(name: vacationNameTextField.text!, fromPlace: fromTextField.text!, ToPlace: toTextField.text!, endDate: endDate, startDate: startDate, arrivalAirport: chosenArrivalAirport, departureAirport: chosenDepartureAirport, position: [], status: VacationStatus.inactive)
        UserServices.createVacation(with: vacation, completion: { [weak self] success in
            if success {
                print(success)
            } else {
                print(Error.self)
            }
        })
    }
    
    
    func checkFields() {
        if vacationNameTextField.text == "" ||
            fromTextField.text == "" ||
            toTextField.text == "" ||
            chosenDepartureAirport == "" ||
            chosenArrivalAirport == "" ||
            VacDates.startDate == nil ||
            VacDates.endDate == nil
        {
            showAlert(with: "Please fill all the fields") {}
        }
    }
    
    
    private func showAlert(with text: String, completion: @escaping ()-> Void){
        let alert = UIAlertController(title: "Missing Information", message: text, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
            alert.dismiss(animated: true, completion: {
                completion()
            })
        })
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func fromTextFieldChanged(_ sender: UITextField) {
        DispatchQueue.main.async {
            guard self.fromTextField.text != "" else { return }
            APIServices.getCities(name: self.fromTextField.text!, completion: { result in
                switch result {
                case .success(let cities):
                    for city in cities {
                        self.citiesStringFrom.append(city.name)
                    }
                    self.dropDownFrom.optionArray = self.citiesStringFrom
                    self.dropDownFrom.didSelect{(selectedText , index ,id) in
                        self.fromCity = selectedText
                        for city in cities {
                            if selectedText == city.name {
                                self.countryCodeFrom = city.country!
                            }
                        }
                    }
                    self.citiesStringFrom.removeAll()
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    
    @IBAction func toTextFieldChanged(_ sender: UITextField) {
        DispatchQueue.main.async {
            guard self.toTextField.text != "" else { return }
            APIServices.getCities(name: self.toTextField.text!, completion: { result in
                switch result {
                case .success(let cities):
                    for city in cities {
                        self.citiesStringTo.append(city.name)
                    }
                    self.dropDownTo.optionArray = self.citiesStringTo
                    self.dropDownTo.didSelect{(selectedText , index ,id) in
                        self.toCity = selectedText
                        for city in cities {
                            if selectedText == city.name {
                                self.countryCodeTo = city.country!
                                self.chosenCity = Place(country: city.country, timezone: city.timezone, name: city.name, lon: city.lon, lat: city.lat, population: city.population, isCapital: city.isCapital)
                            }
                        }
                    }
                    self.citiesStringTo.removeAll()
                case .failure(let error):
                    print(error)
                }
            })
            
            
        }
    }
    
    @IBAction func endFromTextField(_ sender: Any) {
        DispatchQueue.main.async {
            APIServices.getAiports(countryCode: self.countryCodeFrom, completion: {result in
                switch result {
                case .success(let airports):
                    self.departureAirports.removeAll()
                    for airport in airports.data {
                        if airport.iataCode != nil {
                            self.departureAirports.append("\(airport.name) - \(airport.iataCode!)")
                        } else {
                            self.departureAirports.append("\(airport.name)")
                        }
                    }
                    DispatchQueue.main.async {
                        self.departureAirport.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        
    }
    
    
    @IBAction func endToTextField(_ sender: DropDown) {
        DispatchQueue.main.async {
            APIServices.getAiports(countryCode: self.countryCodeTo, completion: {result in
                switch result {
                case .success(let airports):
                    self.arrivalAirports.removeAll()
                    for airport in airports.data {
                        if airport.iataCode != nil {
                            self.arrivalAirports.append("\(airport.name) - \(airport.iataCode!)")
                        } else {
                            self.arrivalAirports.append("\(airport.name)")
                        }
                    }
                    DispatchQueue.main.async {
                        self.arrivalAirport.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
        
    }
    

}

extension PlanViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard collectionView == departureAirport else {
            return arrivalAirports.count
        }
        //if collectionView == arrivalAirport {
        return departureAirports.count
        //}
        //return 0 //countryAirports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == departureAirport {
            let cell = departureAirport.dequeReusableCell(with: AirportCell.self, indexPath: indexPath)
            if departureAirports.isEmpty {
                cell.airportName.text = "Airport Name"
            } else {
                cell.airportName.text = departureAirports[indexPath.row] as? String
            }
            return cell
        } else {
            let cell = arrivalAirport.dequeReusableCell(with: AirportCell.self, indexPath: indexPath)
            if arrivalAirports.isEmpty {
                cell.airportName.text = "Airport Name"
            } else {
                cell.airportName.text = arrivalAirports[indexPath.row] as? String
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == departureAirport {
            self.chosenDepartureAirport = departureAirports[indexPath.row]
            departureAirport.cellForItem(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.2766574323, green: 0.2132521868, blue: 0.6103910804, alpha: 1)
            print(departureAirports[indexPath.row])
        } else {
            self.chosenArrivalAirport = arrivalAirports[indexPath.row]
            arrivalAirport.cellForItem(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.2766574323, green: 0.2132521868, blue: 0.6103910804, alpha: 1)
        }
    }
    
    
    

    
}


extension PlanViewController {
    @IBAction func tappedControl(_ sender: UISegmentedControl) {
        let month: MonthType = {
            switch sender.selectedSegmentIndex {
            case 0:  return .previous
            case 1:  return .current
            default: return .next
            }
        }()
        koyomi.display(in: month)
    }
}


extension PlanViewController: KoyomiDelegate {
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        currentDateLabel.text = dateString
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        if length > invalidPeriodLength {
            print("More than \(invalidPeriodLength) days are invalid period.")
            return false
        }
        VacDates.startDate = date
        VacDates.endDate = toDate
        return true
    }
}

struct VacationDates {
    var startDate: Date?
    var endDate: Date?
}
