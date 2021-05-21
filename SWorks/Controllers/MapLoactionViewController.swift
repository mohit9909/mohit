//
//  MapLoactionViewController.swift
//  SWorks
//
//  Created by Mohit Raina  on 20/05/21.
//

import UIKit
import GoogleMaps

class MapLoactionViewController: UIViewController {
    
    
    var cordinates : Cordinates
    
    init(cordinates : Cordinates) {
        self.cordinates = cordinates
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var maps : GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude:cordinates.lat, longitude: cordinates.long, zoom: 2.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        return mapView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maps.frame = self.view.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coordinates:)` to initialize a `MapViewController` instance.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title =  "Location"
        self.view.addSubview(maps)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: cordinates.lat, longitude: cordinates.long)
        marker.title = "My Location"
        marker.map = maps
        
    }
    
}
