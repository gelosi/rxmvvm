//
//  RestaurantsViewModel.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import RxSwift
import RxCocoa

let BerlinCoordinate = Restaurant.Coordinate(lat:52.507673, lon:13.390335)

let YelpKey = "<set your proper api key here>"

class RestaurantsViewModel {
    
    let currentLocation = Variable(BerlinCoordinate)
    
    lazy var data: Driver<[Restaurant]> = {
        
        return self.currentLocation.asObservable()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .flatMapLatest(restarauntsNearLocation)
            .asDriver(onErrorJustReturn:[])
    }()
    
    
//MARK: data handling
    
    let dataSource = RestaurantsDataSource(network: UrlSessionNetwork(urlSession:URLSession.shared) )
    
    func restarauntsNearLocation(coordinate:Restaurant.Coordinate) -> Observable<[Restaurant]> {
        
        guard let request = RestaurantsViewModel.request(coordinates:coordinate) else {
            return Observable.just([])
        }
        
        return dataSource.getRestaurants(request: request)
    }
    
    // request method can be moved to Endpoint object
    // so, we would do something like:
    // request = RestaurantSearchEndpoint.locationRequest(coordinates)
    
    static func request(coordinates:Restaurant.Coordinate) -> URLRequest? {
        // we can do coordinates boud check for instance
        
        let urlEndpoint = "https://api.yelp.com/v3/businesses/search"
        
        let urlQuery = "categories=restaurants&latitude=\(coordinates.latitude)&longitude=\(coordinates.longitude)"
        
        let urlString = urlEndpoint + "?" + urlQuery
        
        guard let url = URL(string:urlString) else {
            return nil
        }
        
        var request = URLRequest(url:url)
        
        // as well, we can do better by setting default headers inside
        // url session configuration!
        
        guard YelpKey.first != "<" else {
            fatalError("Set proper Yelp Api Key!")
        }
    
        request.addValue("Bearer \(YelpKey)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
