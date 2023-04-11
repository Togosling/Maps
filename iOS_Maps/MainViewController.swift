//
//  ViewController.swift
//  iOS_Maps
//
//  Created by Тагай Абдылдаев on 10/4/23.
//

import UIKit
import MapKit
import SnapKit

extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        annotationView.canShowCallout = true
        return annotationView
    }
}

class MainViewController: UIViewController {
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setupViews()
        setNewRegion()
        setAnnotationsForMap()
        performLocalSerch()
        
    }
    
    fileprivate func performLocalSerch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Apple"
        request.region = mapView.region
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { resp, err in
            if let err = err {
                print("Failed", err)
                return
            }
            resp?.mapItems.forEach({ mapItem in
                
                let placeMark = mapItem.placemark
                var address = ""
                if placeMark.subThoroughfare != nil {
                    address = placeMark.subThoroughfare! + " "
                }
                if placeMark.thoroughfare != nil {
                    address = placeMark.thoroughfare! + " "
                }
                if placeMark.postalCode != nil {
                    address = placeMark.postalCode! + " "
                }
                if placeMark.locality != nil {
                    address = placeMark.locality! + " "
                }
                if placeMark.administrativeArea != nil {
                    address = placeMark.administrativeArea! + " "
                }
                if placeMark.country != nil {
                    address = placeMark.country! + " "
                }
                print(address)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
            })
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)

        }
    }
    
    fileprivate func setAnnotationsForMap() {
        let PekingUniAnnotation = MKPointAnnotation()
        PekingUniAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.992040, longitude: 116.315428)
        PekingUniAnnotation.title = "Peking University"
        PekingUniAnnotation.subtitle = "Haidian"
        mapView.addAnnotation(PekingUniAnnotation)
        
        let QinghuaUniAnnotation = MKPointAnnotation()
        QinghuaUniAnnotation.coordinate = CLLocationCoordinate2D(latitude: 39.99929, longitude: 116.32705)
        QinghuaUniAnnotation.title = "Qinghua University"
        QinghuaUniAnnotation.subtitle = "Haidian"
        mapView.addAnnotation(QinghuaUniAnnotation)
        
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    fileprivate func setNewRegion() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 39.992040, longitude: 116.315428)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func setupViews() {
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }


}

