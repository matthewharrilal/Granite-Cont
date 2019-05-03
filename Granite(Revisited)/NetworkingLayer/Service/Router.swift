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
    
    fileprivate func confiureParameters(withRequest request: inout URLRequest, bodyParameters: Parameters?, urlParameters: Parameters?) throws {
        
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(withRequest: &request, parameters: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(withRequest: &request, parameters: urlParameters)
            }
        }
        
        catch {
            throw NetworkError.encodingFailed
        }
        
    }
    
    fileprivate func addAdditionalHeaders(withRequest request: inout URLRequest, headers: HTTPHeaders) {
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}

