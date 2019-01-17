//
//  Network.swift
//  rxmvvm
//
//  Created by Oleg Shanyuk on 17.01.19.
//  Copyright © 2019 Oleg Shanyuk. All rights reserved.
//

import Foundation


// Those protocols are the basic network abstraction
// necessary for this app purpose
// allows to use any newtork implementation which can be tested to
// call appropriate completion and to cancel request

protocol NetworkTask {
    func cancelTask()
    func startTask()
}

protocol Network {
    func dataRequest(request:URLRequest, completion: @escaping (_ data:Data?, _ error:Error?) -> Void) -> NetworkTask
}


