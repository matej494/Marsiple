//
//  Comments.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

class Comment {
    // TODO: - Setup properties to correspond to Json object from api
    let email: String
    let body: String
    
    init(email: String, body: String) {
        self.email = email
        self.body = body
    }
}
