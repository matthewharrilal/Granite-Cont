//
//  User.swift
//  Granite(Revisited)
//
//  Created by Matthew Harrilal on 5/1/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

class User: Decodable {
    var email: String
    var username: String
    var password: String
    var githubProfileUsername: String
    var languages: [String]

    init(email: String, username: String, password: String, githubProfileUsername: String? = nil, languages: [String]) {
        self.email = email
        self.username = username
        self.password = password
        self.githubProfileUsername = githubProfileUsername ?? ""
        self.languages = languages
    }
    
    convenience init?(username: String, password: String) {
        // May not have username when instantiating the object
        self.init(email: "", username: username, password: password, githubProfileUsername: "", languages: [""])
    }
    
    private enum UserKeys: String, CodingKey {
        case languages
        case password
        case email
        case username
        case githubProfile
        case updatedAt
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        let languages = try container.decode([String].self, forKey: .languages)
        let password = try container.decode(String.self, forKey: .password)
        let email = try container.decode(String.self, forKey: .email)
        let username = try container.decode(String.self, forKey: .email)
        let githubProfileUsername = try container.decode(String.self, forKey: .githubProfile)
        let updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.init(email: email, username: username, password: password, githubProfileUsername: githubProfileUsername, languages: languages)
    }
}
