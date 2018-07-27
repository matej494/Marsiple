//
//  UIBarButtonItem.swift
//  Marsiple
//
//  Created by Matej Korman on 25/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func commentItem(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: LocalizationKey.BarButtonItem.commentTitle.localized(), style: .plain, target: target, action: action)
    }
    
    static func saveItem(target: Any, action: Selector) -> UIBarButtonItem {
        return UIBarButtonItem(title: LocalizationKey.BarButtonItem.saveTitle.localized(), style: .done, target: target, action: action)
    }
}
