//
//  EndpointType.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

protocol EndpointType {
    var baseUrl: URL {get}
    var path: String {get}
    var task: HTTPTask {get}
    var httpMethod: String {get}
}
