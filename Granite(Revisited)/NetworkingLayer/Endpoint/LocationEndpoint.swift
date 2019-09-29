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
}

extension LocationEndpoint: EndpointType {
    var baseUrl: URL {
        guard let url = URL(string: "http://127.0.0.1:3000") else {fatalError("Base Url Could Not Be Configured")}
        return url
    }
    
    var path: String {
        switch self {
        case .postLocation:
            return "/location"
        }
    }
    
    var task: HTTPTask {
        var headers: HTTPHeaders?
        
        
        switch self {
        case .postLocation:
            // Must have cookie from keychain in order to make authorized request
            guard let cookie = keychain.get("cookie") else {fatalError("No Cookie Present")}
            headers = ["Cookie": cookie]
            parameters
            return .requestParametersAndHeaders(bodyParameters: <#T##Parameters?#>, urlParameters: <#T##Parameters?#>, headers: <#T##HTTPHeaders?#>)
        }
    }
    
    var httpMethod: String {
        <#code#>
    }
    
    
}
