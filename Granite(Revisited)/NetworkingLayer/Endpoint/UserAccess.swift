//
//  User.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

enum UserAccess {
    case authenticateUser(username: String, password: String)
    case createUser(user: User)
}


extension UserAccess: EndpointType {
    var baseUrl: URL {
        guard let url = URL(string: "http://127.0.0.1:3000") else {fatalError("Base Url Could Not Be Configured")}
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
        case .authenticateUser(let username, let password):
            
            headers = ["username": username, "password": password ]
            return .requestParametersAndHeaders(bodyParameters: nil, urlParameters: nil, headers: headers)
            
        case .createUser(let user):
            // MARK: TODO Fix login to take email and not username or VICE VERSA have to remain consistent
            parameters = ["email": user.email, "username": user.username, "password": user.password, "githubProfile": String(describing: user.githubProfileUsername), "languages": user.languages]
            
            return .requestParameters(bodyParameters: parameters, urlParameters: nil)
        }
    }
    
    var httpMethod: String {
        return HTTPMethods.post.rawValue
    }
}
