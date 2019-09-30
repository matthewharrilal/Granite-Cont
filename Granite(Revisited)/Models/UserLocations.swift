//
//  UserLocation.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 9/29/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation


class UserLocations: Decodable {
    var user: User
    var locations: [Location]
    
    init(user: User, locations: [Location]) {
        self.user = user
        self.locations = locations
    }
    
    private enum UserLocationKeys: String, CodingKey {
        case locations = "location"
        case user
    }
    
    required convenience init(from decdoder: Decoder) throws {
        let container = try decdoder.container(keyedBy: UserLocationKeys.self)
        let user = try container.decode(User.self, forKey: .user)
        let locations = try container.decode([Location].self, forKey: .locations)
        self.init(user: user, locations: locations)
    }
}
