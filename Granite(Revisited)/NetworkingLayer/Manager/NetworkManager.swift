//
//  NetworkManager.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/2/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

typealias UserCompletion = (_ user: User?, _ error: String?) -> ()
typealias LocationCompletion = (_ location: Location?, _ error: String?) -> ()
typealias UserLocationCompletion = (_ user: UserLocations?, _ error: String?) -> ()

public struct NetworkManager {
    // In charge of containing our routers for each endpoint
    let userAccess = Router<UserAccess>()
    let locationManager = Router<LocationEndpoint>()
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
    // MARK: TODO Should the user be optional when being passed in as an argument?
    guard let user = user else {return}
    
    let userManager = NetworkManager().userAccess
    
    userManager.request(withEndpoint: .authenticateUser(username: user.username, password: user.password)) { (data, response, err) in
        
        if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: response!.url!)
            //            HTTPCookieStorage.sh aredHTTPCookieStorage.setCookies(cookies, forURL: response!.URL!, mainDocumentURL: nil)
            for cookie in cookies {
                
                print("name: \(cookie.name) value: \(cookie.value), ... \(cookie)")
                keychain.set(cookie.value, forKey: cookie.name)
            }
        }
        
        
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
                return completion(nil, NetworkResponse.failed.rawValue)
            }
            
        }
    }
}


func getUserLocations(completion: @escaping UserLocationCompletion) -> Void {
    let locationManager = NetworkManager().locationManager
    
    locationManager.request(withEndpoint: .getLocation) { (data, response, error) in
        if error != nil {
            return completion(nil, error?.localizedDescription)
        }
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success(let responseDescription):
                print("Request was success \(responseDescription)")
                
                guard let data = data else {
                    return completion(nil, NetworkResponse.noData.rawValue)
                }
                
                do {
                    let userLocations = try JSONDecoder().decode(UserLocations.self, from: data)
                    return completion(userLocations, nil)
                }
                    
                    
                catch {
                    return completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
                
            case .failure(let responseDescription):
                print("Request was a failure \(responseDescription)")
                return completion(nil, NetworkResponse.failed.rawValue)
            }
        }
    }
}

func postLocation(withLocation location: Location, completion: @escaping LocationCompletion) -> Void {
    let locationManager = NetworkManager().locationManager
    let semaphore = DispatchSemaphore(value: 0)
    
    locationManager.request(withEndpoint: .postLocation(latitude: location.latitude, longitude: location.longitude)) { (data, response, error) in
        semaphore.signal()
        if error != nil {
            print("ERROR ------->   \(error?.localizedDescription)")
            return completion(nil, error?.localizedDescription)
        }
        
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            
            switch result {
            case .success(let responseDescription):
                print("Request was success \(responseDescription)")
                
                guard let data = data else {
                    return completion(nil, NetworkResponse.noData.rawValue)
                }
                
                do {
                    let location = try JSONDecoder().decode(Location.self, from: data)
                    return completion(location, nil)
                }
                    
                
                catch {
                    return completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
                
            case .failure(let responseDescription):
                print("Request was a failure \(responseDescription)")
                return completion(nil, NetworkResponse.failed.rawValue)
            }
        }
    }
     semaphore.wait(timeout: .distantFuture)
}

func createUser(withUser user: User?, completion: @escaping UserCompletion) -> Void {
    // MARK: TODO Should the user be optional when being passed in as an argument?
    guard let user = user else {return}
    
    let userManager = NetworkManager().userAccess
    
    
    
    userManager.request(withEndpoint: .createUser(user: user)) { (data, response, err) in
        if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: response!.url!)
            //            HTTPCookieStorage.sh aredHTTPCookieStorage.setCookies(cookies, forURL: response!.URL!, mainDocumentURL: nil)
            for cookie in cookies {
                
                print("name: \(cookie.name) value: \(cookie.value), ... \(cookie)")
                keychain.set(cookie.value, forKey: cookie.name)
            }
        }
        
        if err != nil {
            return completion(nil, err?.localizedDescription)
        }
        
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            
            switch (result) {
            case .success(let requestExecutionDescription):
                print("Request was success \(requestExecutionDescription)")
                
                guard let data = data else {
                    return completion(nil, NetworkResponse.noData.rawValue)
                }
                
                do {
                    let createdUser = try JSONDecoder().decode(User.self, from: data)
                    return completion(createdUser, nil)
                }
                    
                catch {
                    return completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
                
            case .failure(let requestFailureDescription):
                print("Request failed \(requestFailureDescription)")
                
                return completion(nil, NetworkResponse.failed.rawValue)
            }
        }
    }
}
