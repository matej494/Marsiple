//
//  Album.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

struct Album {
    let photos: [UIImage]
    
    init(images: [UIImage]) {
        self.photos = images
    }
}
