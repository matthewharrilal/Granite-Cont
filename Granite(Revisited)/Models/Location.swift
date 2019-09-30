//
//  Location.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 9/28/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

class Location: Decodable {
    var latitude: Float
    var longitude: Float
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    private enum LocationKeys: CodingKey {
        case latitude
        case longitude
    }
    
    
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationKeys.self)
        let latitude = try container.decode(Float.self, forKey: .latitude)
        let longitude = try container.decode(Float.self, forKey: .longitude)
        self.init(latitude: latitude, longitude: longitude)
    }

    
    
}

