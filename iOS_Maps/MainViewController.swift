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
        
    }
    
    fileprivate func setupViews() {
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }


}

