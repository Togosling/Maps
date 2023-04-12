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
extension MKMapItem {
    func address() -> String {
        var address = ""
        if placemark.subThoroughfare != nil {
            address = placemark.subThoroughfare! + " "
        }
        if placemark.thoroughfare != nil {
            address = placemark.thoroughfare! + " "
        }
        if placemark.postalCode != nil {
            address = placemark.postalCode! + " "
        }
        if placemark.locality != nil {
            address = placemark.locality! + " "
        }
        if placemark.administrativeArea != nil {
            address = placemark.administrativeArea! + " "
        }
        if placemark.country != nil {
            address = placemark.country! + " "
        }
        return address
    }
}


class MainViewController: UIViewController {
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        setupViews()
        setNewRegion()
        setSearchUI()
        
                
    }
    let searchTextField = UITextField()

    
    fileprivate func setSearchUI() {
        
        searchTextField.placeholder = "Search"
        
        let whiteConttainer = UIView()
        whiteConttainer.backgroundColor = .white
        view.addSubview(whiteConttainer)
        whiteConttainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        whiteConttainer.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        searchTextField.addTarget(self, action: #selector(handleSearch), for: .editingChanged)
        
    }
    
    @objc func handleSearch() {
        performLocalSerch()
    }
    
    fileprivate func performLocalSerch() {

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTextField.text
        request.region = mapView.region
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { resp, err in
            if let err = err {
                print("Failed", err)
                return
            }
            self.mapView.removeAnnotations(self.mapView.annotations)
            resp?.mapItems.forEach({ mapItem in

                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
            })
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)

        }
    }
    
    
    fileprivate func setNewRegion() {
        let centerCoordinate = CLLocationCoordinate2D(latitude: 39.924583, longitude: 116.407753)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func setAnnotationsForMap() {
        let Alcatras = MKPointAnnotation()
        Alcatras.coordinate = CLLocationCoordinate2D(latitude: 37.826471, longitude:  -122.421979)
        Alcatras.title = "Alcatras"
        Alcatras.subtitle = "CA"
        mapView.addAnnotation(Alcatras)

        let SienceAcademy = MKPointAnnotation()
        SienceAcademy.coordinate = CLLocationCoordinate2D(latitude: 37.771401, longitude: -122.466439)
        SienceAcademy.title = "Sience Academy"
        SienceAcademy.subtitle = "CA"
        mapView.addAnnotation(SienceAcademy)

        mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    fileprivate func setupViews() {
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
}

