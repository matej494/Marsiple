//
//  Todo.swift
//  Marsiple
//
//  Created by Matej Korman on 30/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct Todo {
    let id: Int
    var title: String
    var completed: Bool
    let userId: Int
    
    init(id: Int, title: String, completed: Bool, userId: Int) {
        self.id = id
        self.title = title
        self.completed = completed
        self.userId = userId
    }
}
