//
//  HTTPTask.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, headers: HTTPHeaders?)
}

public protocol ParameterEncoder {
    // In charge of configuring parameters on request passed by reference
    static func encode(withRequest request: inout URLRequest, parameters: Parameters) throws
}


