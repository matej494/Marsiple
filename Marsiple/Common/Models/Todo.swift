//
//  Todo.swift
//  Marsiple
//
//  Created by Matej Korman on 30/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct Todo: Codable, Identifiable, Pathable {
    static let path = MartianApi.URLs.todos
    static let parentPath = MartianApi.URLs.users
    
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(completed, forKey: .completed)
        try container.encode(userId, forKey: .userId)
    }
}

extension Todo: Equatable {
    static func == (lhs: Todo, rhs: Todo) -> Bool {
        return lhs.title == rhs.title &&
            lhs.completed == rhs.completed
    }
}
