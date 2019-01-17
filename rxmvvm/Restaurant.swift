//
//  Restaurant.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import UIKit

class Restaurant: Codable {
    
    class Coordinate: Codable {
        let latitude:Double
        let longitude:Double
        
        init(lat:Double, lon:Double) {
            self.latitude = lat
            self.longitude = lon
        }
    }
    
    let name:String
    let coordinates:Coordinate
}
