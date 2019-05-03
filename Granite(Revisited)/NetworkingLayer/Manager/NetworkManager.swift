//
//  NetworkManager.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

typealias UserCompletion = (_ user: User?, _ error: String?) -> ()

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


func authenticateUser(withUser user: User?, completion: @escaping UserCompletion) -> Void {
    guard let user = user else {return}
    
    let userManager = NetworkManager().userAccess
    
    userManager.request(withEndpoint: .authenticateUser(email: user.email, username: user.username, password: user.password)) { (data, response, err) in
        if err != nil {
            return completion(nil, err?.localizedDescription)
        }
        
        // Converting response to gain more insight and access to the status code pertaining to the http protocol itself
        if let response = response as? HTTPURLResponse {
            // Obtain description of request execution that the response' status code correlates to
            let result = handleNetworkResponse(response)
            
            switch (result) {
            case .success(let requestExecutionDescription):
                print("Request was success \(requestExecutionDescription)")
                
                // If data comes back and is nil
                guard let data = data else {
                    return completion(nil , NetworkResponse.noData.rawValue)
                }
                
                // Try the deserialization of data that has come back from the request
                do {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    return completion(user, nil)
                }
                catch {
                   return completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
                
            case .failure(let requestFailureDescription):
                print("Request was a failiure \(requestFailureDescription)")
            }
           
        }
    }
}
