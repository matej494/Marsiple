//
//  Photo.swift
//  Marsiple
//
//  Created by Matej Korman on 24/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

struct Photo: Codable, Identifiable, Pathable {
    static let path = MartianApi.URLs.photos
    static let parentPath = MartianApi.URLs.albums

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
