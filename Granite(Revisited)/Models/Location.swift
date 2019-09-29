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
}
