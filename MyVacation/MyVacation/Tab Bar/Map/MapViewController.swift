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
    private var places: InterestingPlaces?
    private var vacations: [Vacation]?
    private var selectedVacation: Vacation?
    private var selectedOneVacation: Bool = false
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        // for testing purpose
        DispatchQueue.main.async {
            APIServices.getPlace(category: PlaceCategory.hotel,
                                 lat: 41.716667,
                                 lon: 44.783333,
                                 completion: { result in
                switch result {
                case .success(let places):
                    self.places = places
                    self.addAnnorations()
                case .failure(let error):
                    print(error)
                }
            })
        }
        setUpMap()
        setUpMenu()
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
        let mapMeterds: Double = 5_000
        // testing purpose (then should get this coordinates according to vacation)
        let coordinate = CLLocationCoordinate2D(latitude: 41.716667, longitude: 44.783333)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: mapMeterds, longitudinalMeters: mapMeterds)
        mapView.setRegion(region, animated: true)
    }
    
    private func update(with vacationName: String) {
        selectedVacation = vacations?.filter({ $0.name == vacationName }).first
    }
    
    private func addAnnorations(){
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        var places = places
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
