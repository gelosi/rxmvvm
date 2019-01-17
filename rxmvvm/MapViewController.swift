//
//  MapViewController.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import UIKit
import MapKit
import RxCocoa
import RxSwift
import RxMKMapView

class RestaurantAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(restaurant.coordinates.latitude, restaurant.coordinates.longitude)
    }
    
    var title: String? {
        return restaurant.name
    }
    
    let restaurant: Restaurant
    
    init(restaurant:Restaurant) {
        self.restaurant = restaurant
    }
}

class MapViewController: UIViewController {
    
    @IBOutlet var mapView:MKMapView?
    
    // here we can do some DI work to abstract
    // view controller from concrete view model
    var viewModel = RestaurantsViewModel()
    let disposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let berlin = CLLocationCoordinate2D(latitude: BerlinCoordinate.latitude, longitude: BerlinCoordinate.longitude)

        mapView?.setCenter(berlin, animated:false)
        mapView?.setRegion(MKCoordinateRegion(center: berlin, latitudinalMeters: 2000, longitudinalMeters: 2000), animated:true)
        
        // setup map view with Rx extension
        
        mapView?.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        mapView?.rx
            .regionDidChangeAnimated
            .subscribe(onNext: { _ in
                print("Map region changed")
            })
            .disposed(by: disposeBag)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
