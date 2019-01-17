//
//  MapViewController.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView:MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let berlin = CLLocationCoordinate2D(latitude: BerlinCoordinate.latitude, longitude: BerlinCoordinate.longitude)

        mapView?.setCenter(berlin, animated:false)
    }
    


}
