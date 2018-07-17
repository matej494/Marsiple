//
//  MartianColors.swift
//  Marsiple
//
//  Created by Matej Korman on 17/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

enum MatrianColor {
    case red
    case dark
    case darkGray
    case gray
    case lightGray
    
    var value: UIColor {
        switch self {
        case .red:
            return UIColor(ciColor: CIColor(red: 0.937, green: 0.251, blue: 0.349))
        case .dark:
            return UIColor(ciColor: CIColor(red: 0.239, green: 0.239, blue: 0.239))
        case .darkGray:
            return UIColor(ciColor: CIColor(red: 0.557, green: 0.557, blue: 0.557))
        case .gray:
            return UIColor(ciColor: CIColor(red: 0.78, green: 0.78, blue: 0.78))
        case .lightGray:
            return UIColor(ciColor: CIColor(red: 0.961, green: 0.961, blue: 0.961))
        }
    }
}
