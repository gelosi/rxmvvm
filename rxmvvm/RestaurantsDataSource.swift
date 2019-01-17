//
//  RestaurantsDataSource.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import RxSwift
import RxCocoa

class RestaurantsDataSource {
    
    let network:Network
    
    init(network:Network) {
        self.network = network
    }
    
    func getRestaurants(request:URLRequest) -> Observable<[Restaurant]> {
        return Observable.create { observer in
            let task = self.network.dataRequest(request: request, completion: { (data, error) in
                guard let data = data, error == nil else {
                    observer.on(.error(error ?? RxCocoaURLError.unknown))
                    return
                }
                
                let result = RestaurantsDataSource.parseRestaurants(data: data)
                
                observer.on(.next(result))
                observer.on(.completed)
            })
            
            return Disposables.create {
                task.cancelTask()
            }
        }
    }
    
    class func parseRestaurants(data:Data) -> [Restaurant] {
        let restaurants = try! JSONDecoder().decode([Restaurant].self, from: data)
        return restaurants
    }
}
