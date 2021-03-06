//
//  MatrianApi.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct MartianApi {
    static let url = URL(string: "https://demo.martian.agency/api")
    
    struct Headers {
        static let defaultContentType = "application/json"
        static let xAuthValue = "bWFydGlhbmFuZG1hY2hpbmU="
    }
    
    struct URLs {
        static let posts = "posts"
        static let comments = "comments"
        static let albums = "albums"
        static let photos = "photos"
        static let users = "users"
        static let todos = "todos"
    }
}
