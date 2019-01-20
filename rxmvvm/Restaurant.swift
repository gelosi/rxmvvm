//
//  Restaurant.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import MapKit
import UIKit

class Restaurant: Codable {
    
    class Coordinate: Codable {
        let latitude: Double
        let longitude: Double

        lazy var coordinate2d = {
            CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        }
        
        init(lat: Double, lon: Double) {
            self.latitude = lat
            self.longitude = lon
        }

        init(coordinate2d: CLLocationCoordinate2D) {
            self.latitude = coordinate2d.latitude
            self.longitude = coordinate2d.longitude
        }
    }
    
    let name: String
    let coordinates: Coordinate
}
