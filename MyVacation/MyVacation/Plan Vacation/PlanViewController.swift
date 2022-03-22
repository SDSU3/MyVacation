//
//  PlanViewController.swift
//  MyVacation
//
//  Created by Tatia Sebiskveradze on 14.03.22.
//

import UIKit
import Koyomi

class PlanViewController: MainViewController {
    
    @IBOutlet weak var vacationNameTextField: UITextField!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var departureAirport: UICollectionView!
    @IBOutlet weak var arrivalAirport: UICollectionView!
    fileprivate let invalidPeriodLength = 90
    
    var VacDates = VacationDates()
    
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

        // Do any additional setup after loading the view.
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
        let plan = Plan(name: vacationNameTextField.text!, from: fromTextField.text!, to: toTextField.text!, startDate: startDate, endDate: endDate, departure: departureAirport.description, arrival: arrivalAirport.description)
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
