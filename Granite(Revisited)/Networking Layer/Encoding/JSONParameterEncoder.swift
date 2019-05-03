//
//  JSONParameterEncoder.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(withRequest request: inout URLRequest, parameters: Parameters) throws {
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = data
            
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json;", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json;", forHTTPHeaderField: "Accept")
            }
        }
        catch {
            throw NetworkError.encodingFailed
        }
    }
}
