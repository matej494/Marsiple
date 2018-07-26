//
//  Comments.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class Comment: Codable {
    let id: Int
    let name: String
    let email: String
    let body: String
    let postId: Int
    
    init(id: Int, name: String, email: String, body: String, postId: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.body = body
        self.postId = postId
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case body
        case postId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        body = try container.decode(String.self, forKey: .body)
        postId = try container.decode(Int.self, forKey: .postId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(body, forKey: .body)
        try container.encode(postId, forKey: .postId)
    }
}
