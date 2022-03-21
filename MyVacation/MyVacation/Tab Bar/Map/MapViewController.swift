//
//  MapViewController.swift
//  MyVacation
//
//  Created by Salome Sulkhanishvili on 15.03.22.
//

import UIKit
import MapKit

class MapViewController: MainViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var places: InterestingPlaces?
    @IBOutlet weak var vacationMenuButton: UIButton!
    
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
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - init
    static func load(with places: InterestingPlaces? = nil) -> MapViewController {
       let viewController = MapViewController.loadFromStoryboard()
        viewController.places = places
       return viewController
    }
    
    private func setUpMenu() {
        vacationMenuButton.showsMenuAsPrimaryAction = true
        vacationMenuButton.roundCorners(with: 10)
        vacationMenuButton.addShadow(radius: 2)
        // add in UIAction all the vacations this one is just for testing purpose
        let items = UIMenu(title: "more", options: .displayInline, children: [
            UIAction(title: "one", handler: {_ in self.update(with: "one")}),
            UIAction(title: "two", handler: {_ in self.update(with: "two")})
        ])
        let menu = UIMenu(title: "", children: [items])
        vacationMenuButton.menu = menu
    }
    
    private func update(with vacation: String) {
        print("do all the updates here")
    }
    private func setUpMap(){
        let mapMeterds: Double = 10_000
        // testing purpose (then should get this coordinates according to vacation)
        let coordinate = CLLocationCoordinate2D(latitude: 41.716667, longitude: 44.783333)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: mapMeterds, longitudinalMeters: mapMeterds)
        mapView.setRegion(region, animated: true)
    }
    
    private func addAnnorations(){
        places?.places?.forEach({ place in
            let annotation = MKPointAnnotation()
            annotation.title = place.title
            annotation.subtitle = place.category
            guard let lat = place.position?[0], let lon = place.position?[1] else { return }
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            mapView.addAnnotation(annotation)
            
        })
    }
}

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
