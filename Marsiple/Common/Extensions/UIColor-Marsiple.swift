//
//  UIColor.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }
    
    static var martianRed: UIColor {
        return UIColor(red: 239, green: 64, blue: 89)
    }

    static var martianDark: UIColor {
        return UIColor(red: 61, green: 61, blue: 61)
    }
    
    static var martianDarkGrey: UIColor {
        return UIColor(red: 142, green: 142, blue: 142)
    }
    
    static var martianGrey: UIColor {
        return UIColor(red: 199, green: 199, blue: 199)
    }
    
    static var martianLightGrey: UIColor {
        return UIColor(red: 245, green: 245, blue: 245)
    }
}
