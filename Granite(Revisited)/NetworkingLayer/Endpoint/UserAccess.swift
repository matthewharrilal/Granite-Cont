//
//  User.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

enum UserAccess {
    case authenticateUser(email: String, username: String, password: String)
    case createUser(user: User)
}


extension UserAccess: EndpointType {
    var baseUrl: URL {
        guard let url = URL(string: "localhost:3000/") else {return}
        return url
    }
    
    var path: String {
        switch self {
        case .authenticateUser:
            return "/login"
            
        case .createUser:
            return "/signup"
        }
    }
    
    var task: HTTPTask {
        var headers: HTTPHeaders?
        var parameters: Parameters?
    
        switch self {
        case .authenticateUser( _ , let username, let password):
            
            headers = ["username": username, "password": password ]
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, headers: headers)
            
        case .createUser(let user):
            parameters = ["email": user.email, "username"]
        }
    }
    
    var httpMethod: String {
        <#code#>
    }
    
    
}