//
//  RestaurantsDataSource.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import RxCocoa
import RxSwift

class RestaurantsDataSource {
    let network: Network
    init(network: Network) {
        self.network = network
    }
    
    func getRestaurants(request: URLRequest) -> Observable<[Restaurant]> {
        return Observable.create { observer in
            let task = self.network.dataRequest(request: request) { data, error in
                guard let data = data, error == nil else {
                    observer.on(.error(error ?? RxCocoaURLError.unknown))
                    return
                }
                
                let result = RestaurantsDataSource.parseRestaurants(data: data)
                
                observer.on(.next(result))
                observer.on(.completed)
            }
            
            task.startTask()
            
            return Disposables.create {
                task.cancelTask()
            }
        }
    }
    
    class func parseRestaurants(data: Data) -> [Restaurant] {
        // force-unwrap set on purpose here
        // as I'm missing time to test model is parsed out properly
        // so, it's a crash point to the moment it's done right
        
        class YeplResponseWrapper: Codable {
            let businesses: [Restaurant]
        }
        
        let response = try? JSONDecoder().decode(YeplResponseWrapper.self, from: data)
        
        return response?.businesses ?? []
    }
}
