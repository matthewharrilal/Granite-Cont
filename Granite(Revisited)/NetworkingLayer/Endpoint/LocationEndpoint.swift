//
//  LocationEndpoint.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 9/28/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import KeychainSwift
var keychain = KeychainSwift()

enum LocationEndpoint {
    case postLocation(latitude: Float, longitude: Float)
    case getLocation
}

extension LocationEndpoint: EndpointType {
    var baseUrl: URL {
        guard let url = URL(string: "http://127.0.0.1:3000") else {fatalError("Base Url Could Not Be Configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .postLocation:
            fallthrough
        case .getLocation:
            return "/location"
            
        }
    }
    
    var task: HTTPTask {
        var headers: HTTPHeaders?
        var parameters: Parameters?
        
        guard let cookie = keychain.get("nToken") else {fatalError("No Cookie Present")}
        headers = ["nToken": cookie]
        
        switch self {
        case .postLocation(let latitude, let longitude):
            // Must have cookie from keychain in order to make authorized request
            
            parameters = ["latitude": latitude, "longitude": longitude]
            
            return .requestParametersAndHeaders(bodyParameters: parameters, urlParameters: nil, headers: headers)
            
        case .getLocation:
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, headers: headers)
            
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getLocation:
            return HTTPMethods.get.rawValue
            
        case .postLocation:
            return HTTPMethods.post.rawValue
        }
    }
    
    
}
