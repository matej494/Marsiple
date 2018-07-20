//
//  UIView-Marsiple.swift
//  Marsiple
//
//  Created by Matej Korman on 18/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIView {
    class func autolayoutView() -> Self {
        let instance = self.init()
        instance.translatesAutoresizingMaskIntoConstraints = false
        return instance
    }
    
    func autolayoutView() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
