//
//  Album.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String
    
    init(userId: Int, id: Int, title: String) {
        self.userId = userId
        self.id = id
        self.title = title
    }
}
