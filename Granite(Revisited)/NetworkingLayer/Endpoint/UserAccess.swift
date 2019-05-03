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
        <#code#>
    }
    
    var path: String {
        <#code#>
    }
    
    var task: HTTPTask {
        <#code#>
    }
    
    var httpMethod: String {
        <#code#>
    }
    
    
}
