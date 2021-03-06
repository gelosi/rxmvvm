//
//  MapViewController.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import MapKit
import RxCocoa
import RxMKMapView
import RxSwift
import UIKit


class RestaurantAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(restaurant.coordinates.latitude, restaurant.coordinates.longitude)
    }
    
    var title: String? {
        return restaurant.name
    }
    
    let restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    // here we can do some DI work to abstract
    // view controller from concrete view model
    var viewModel = RestaurantsViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let berlin = viewModel.currentLocation.value.coordinate2d()
        
        mapView.setCenter(berlin, animated: false)
        mapView.setRegion(MKCoordinateRegion(center: berlin, latitudinalMeters: 2_000, longitudinalMeters: 2_000), animated: true)
        
        viewModel.data
            .map { restaurants -> [MKAnnotation] in
                print("transforming to mkannotation")
                return restaurants.map { restaurant in
                    RestaurantAnnotation(restaurant: restaurant)
                }
            }
            .asDriver(onErrorJustReturn: [])
            .drive(mapView.rx.annotations)
            .disposed(by: disposeBag)
        
        mapView.rx
            .region
            .map { region -> Restaurant.Coordinate in
                return Restaurant.Coordinate(coordinate2d: region.center)
            }
            .asObservable()
            .bind(to: viewModel.currentLocation)
            .disposed(by: disposeBag)
        
        mapView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        view.canShowCallout = true
        return view
    }
}
