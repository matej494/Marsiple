//
//  Post.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class Post: Codable, Identifiable, Pathable {
    static let path = MartianApi.URLs.posts
    static let parentPath = MartianApi.URLs.users

    let id: Int
    let title: String
    let body: String
    let userId: Int
    
    init(id: Int, title: String, body: String, userId: Int) {
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
    }
}
