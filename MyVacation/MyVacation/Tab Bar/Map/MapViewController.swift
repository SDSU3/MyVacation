//
//  MapViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit
import MapKit

class MapViewController: MainViewController {

    //MARK: - IBOutlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var vacationMenuButton: UIButton!
    
    //properties
    private var vacations: [Vacation]?
    private var selectedVacation: Vacation?
    private var selectedOneVacation: Bool = false
    private var lat: Double {
        return self.selectedVacation?.position?.first ?? 41.716667
    }
    private var lon: Double {
        return self.selectedVacation?.position?.last ?? 44.783333
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        if !selectedOneVacation {
            DispatchQueue.main.async { [weak self] in
                self?.loadVacations()
            }
        } else {
            setUpMenu()
            setUpMap()
            addAnnorations()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = !selectedOneVacation
    }
    
    // MARK: - init
    static func load(vacations: [Vacation]? = nil, selectedVacation: Bool = false) -> MapViewController {
       let viewController = MapViewController.loadFromStoryboard()
       viewController.vacations = vacations
       viewController.selectedOneVacation = selectedVacation
       return viewController
    }
    
    private func setUpMenu() {
        guard let vacations = vacations else { return }
        vacationMenuButton.isHidden = selectedOneVacation
        
        vacationMenuButton.showsMenuAsPrimaryAction = true
        vacationMenuButton.roundCorners(with: 10)
        vacationMenuButton.addShadow(radius: 2)
        
        let menuItems = vacations.map{ vacation in
            return UIAction(title: vacation.ToPlace, handler: {_ in self.update(with: vacation.name)})
        }
        
        let items = UIMenu(title: "more", options: .displayInline, children: menuItems)
        let menu = UIMenu(title: "", children: [items])
        vacationMenuButton.menu = menu
        selectedVacation = vacations.first
    }
    
    private func setUpMap(){
        let mapMeterds: Double = 7_000
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: mapMeterds, longitudinalMeters: mapMeterds)
        mapView.setRegion(region, animated: true)
    }
    
    private func update(with vacationName: String) {
        selectedVacation = vacations?.filter({ $0.name == vacationName }).first
        addAnnorations()
        setUpMap()
    }
    
    private func addAnnorations(){
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        var places: InterestingPlaces?
        if selectedVacation != nil {
            places = selectedVacation?.interestingPlaces
        }
        
        places?.places?.forEach({ place in
            let annotation = MKPointAnnotation()
            annotation.title = place.title
            annotation.subtitle = place.category
            guard place.position?.count == 2, let lat = place.position?[0], let lon = place.position?[1] else { return }
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(annotation)
        })
    }
    
    private func loadVacations() {
        UserServices.loadVacations(completion: { [weak self] result in
            switch result {
            case .success(let vacations):
                guard let vacations = vacations else { return }

                self?.vacations = vacations
                DispatchQueue.main.async {
                    self?.setUpMenu()
                    self?.setUpMap()
                    self?.addAnnorations()
                }
            case .failure(_):
                print("error could not load vacaitons")
            }
        })
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            annotationView?.annotation = annotation
        }
        
        guard let categoryName = annotation.subtitle as? String else {
            return annotationView
        }
        let category = PlaceCategory(rawValue: categoryName) ?? .unknown
        let image = category.getImage()
        annotationView?.image = image
        annotationView?.canShowCallout = true
        return annotationView
    }
}
