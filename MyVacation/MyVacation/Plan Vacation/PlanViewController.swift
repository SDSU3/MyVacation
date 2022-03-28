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
    
    
    @IBAction func nextButton(_ sender: Any) {
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
    
    @IBAction func fromTextFieldChanged(_ sender: UITextField) {
        DispatchQueue.main.async {
            guard self.fromTextField.text != "" else { return }
            APIServices.getCities(name: self.fromTextField.text!, completion: { result in
                switch result {
                case .success(let cities):
                    for city in cities {
                        self.citiesStringFrom.append(city.name)
                    }
                    print("Dropdown option: \(self.citiesStringFrom)")
                    self.dropDownFrom.optionArray = self.citiesStringFrom
                    self.dropDownFrom.didSelect{(selectedText , index ,id) in
                        self.fromCity = selectedText
                        for city in cities {
                            if selectedText == city.name {
                                self.countryCodeFrom = city.country!
                                
                            }
                        }
                    }
                    print("Country code is: \(self.countryCodeFrom)")
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
                    print("Dropdown option: \(self.citiesStringTo)")
                    self.dropDownTo.optionArray = self.citiesStringTo
                    self.dropDownTo.didSelect{(selectedText , index ,id) in
                        self.toCity = selectedText
                        for city in cities {
                            if selectedText == city.name {
                                self.countryCodeTo = city.country!
                                
                            }
                        }
                    }
                    print("Country Code is: \(self.countryCodeTo)")
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
                    print("Airoports from all information : \(airports.data)")
                    self.departureAirports.removeAll()
                    for airport in airports.data {
                        if airport.iataCode != nil {
                            self.departureAirports.append("\(airport.name) - \(airport.iataCode!)")
                        } else {
                            self.departureAirports.append("\(airport.name)")
                        }
                    }
                    print("Airport from name options: \(self.departureAirports)")
                case .failure(let error):
                    print(error)
                }
            })
            self.departureAirport.reloadData()
        }
        
    }
    
    
    @IBAction func endToTextField(_ sender: DropDown) {
        DispatchQueue.main.async {
            APIServices.getAiports(countryCode: self.countryCodeTo, completion: {result in
                switch result {
                case .success(let airports):
                    print("Airoports to all information : \(airports.data)")
                    self.arrivalAirports.removeAll()
                    for airport in airports.data {
                        if airport.iataCode != nil {
                            self.arrivalAirports.append("\(airport.name) - \(airport.iataCode!)")
                        } else {
                            self.arrivalAirports.append("\(airport.name)")
                        }
                    }
                    print("Airport from name options: \(self.arrivalAirports)")
                case .failure(let error):
                    print(error)
                }
            })
            self.arrivalAirport.reloadData()
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
            print(chosenDepartureAirport)
        } else {
            self.chosenArrivalAirport = arrivalAirports[indexPath.row]
            print(chosenArrivalAirport)
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
