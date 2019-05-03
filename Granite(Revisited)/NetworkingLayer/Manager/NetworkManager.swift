//
//  NetworkManager.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

typealias UserCompletion = (_ user: User?, _ error: Error?) -> ()

public struct NetworkManager {
    // In charge of containing our routers for each endpoint
    let userAccess = Router<UserAccess>()
}



// Some elegant enums used to be able to mark the status of the request at every step of the way such as the decoding process, the network request process, and others that you can see below
public enum NetworkResponse: String {
    // Possible error scenarios provides an abstracted and modularized form of error handling
    case success = "Network call was a success"
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "The network call resulted in a failure"
    case noData = "The network call resulted in no data being sent back"
    case unableToDecode = "Unable to decode the response"
}

public enum Result<String> {
    case success(String)
    case failure(String)
}



fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    // Depending on the status code we can infer the origin of the error
    switch response.statusCode {
    case 200 ... 299:
        return .success(NetworkResponse.success.rawValue)
    case 401 ... 500:
        return .failure(NetworkResponse.authenticationError.rawValue)
    case 501 ... 599:
        return .failure(NetworkResponse.badRequest.rawValue)
    case 600:
        return .failure(NetworkResponse.outdated.rawValue)
    default:
        return .failure(NetworkResponse.failed.rawValue)
        
    }
}


func authenticateUser(withUser user: User?, completion: @escaping UserCompletion) {
    guard let user = user else {return}
    
    let userManager = NetworkManager().userAccess
    
    userManager.request(withEndpoint: .createUser(user: user)) { (data, response, err) in
        if err != nil {
            completion(nil, err)
        }
        
        // Converting response to gain more insight and access to the status code pertaining to the http protocol itself
        if let response = response as? HTTPURLResponse {
            
        }
    }
}
