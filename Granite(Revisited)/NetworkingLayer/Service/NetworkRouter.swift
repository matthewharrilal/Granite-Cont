//
//  NetworkRouter.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation


public typealias RequestCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    associatedtype Endpoint: EndpointType
    
    func request(withEndpoint endpoint: Endpoint, completion: @escaping RequestCompletion)
    
    func cancel()
}
