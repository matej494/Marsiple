//
//  Album.swift
//  Marsiple
//
//  Created by Matej Korman on 20/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

struct Album { //TODO: - Setup properties to correspond to Json object from api
    let photos: [UIImage]
    
    init(images: [UIImage]) {
        self.photos = images
    }
}
