//
//  User.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

struct User {
    var email: String
    var username: String
    var password: String
    var githubProfileUsername: String?
    var languages: [String]
    
    init(email: String, username: String, password: String, githubProfileUsername: String?, languages: [String]) {
        self.email = email
        self.username = username
        self.password = password
        self.githubProfileUsername = githubProfileUsername
        self.languages = languages
    }
    
    convenience init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
