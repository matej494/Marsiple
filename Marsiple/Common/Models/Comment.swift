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
}
