//
//  Pathable.swift
//  Marsiple
//
//  Created by Matej Korman on 13/08/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import Foundation

protocol Pathable {
    static var path: String { get }
    static var parentPath: String { get }
}
