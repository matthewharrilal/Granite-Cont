//
//  Errors.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

public enum NetworkError: String, Error {
    case parametersNil = "Missing parameters on request"
    
    case encodingFailed = "Failed to encode parameters on request"
    
    case missingUrl = "Failed to provide a url"
}
