//
//  UrlSessionNetwork.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import RxCocoa
import UIKit


class UrlSessionNetwork: NSObject, Network {
    class UrlSessionNetworkTask: NetworkTask {
        
        let task: URLSessionTask
        
        init(task: URLSessionTask) {
            self.task = task
        }
        
        func cancelTask() {
            task.cancel()
        }
        
        func startTask() {
            task.resume()
        }
    }
    
    func dataRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> NetworkTask {

        let task = self.urlSession.dataTask(with: request) { data, _, error in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            completion(data, nil)
        }
        
        return UrlSessionNetworkTask(task: task)
    }
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
}
