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
        let session = URLSession.shared
        
        do {
            let request = try self.buildRequest(withRoute: endpoint)
            let task = session.dataTask(with: request) { (data, response, err) in
                completion(data, response, err)
            }
            
            task.resume()
        }
        catch {}
    }
    
    func cancel() {
        print("Canceling Task ...")
    }
    
    fileprivate func buildRequest(withRoute route: Endpoint) throws -> URLRequest {
        
        // Wait for ten seconds before returning the request
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod
        
        
        do {
            switch (route.task) {
            case .request:
                // If request needs no configuration just parse empty header field
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try confiureParameters(withRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let headers):
                addAdditionalHeaders(withRequest: &request, headers: headers)
                try confiureParameters(withRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
            }
            
            return request
        }
            
        catch {
            throw error
        }
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
    
    fileprivate func addAdditionalHeaders(withRequest request: inout URLRequest, headers: HTTPHeaders?) {
        guard let headers = headers else {return}
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }
}

