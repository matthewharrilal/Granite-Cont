//
//  Router.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

// Applying a type constraint to our generic router has to be of type endpoint (ROUTE THAT HAS CONFIGURATIONS)
class Router<Endpoint: EndpointType>: NetworkRouter {
    func request(withEndpoint endpoint: Endpoint, completion: @escaping RequestCompletion) {
        <#code#>
    }
    
    func cancel() {
        <#code#>
    }
    
    
}

