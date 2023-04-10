//
//  ViewController.swift
//  iOS_Maps
//
//  Created by Тагай Абдылдаев on 10/4/23.
//

import UIKit
import MapKit
import SnapKit

class MainViewController: UIViewController {
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setNewRegion()
        
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

