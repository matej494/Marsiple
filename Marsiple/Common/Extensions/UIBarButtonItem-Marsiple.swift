//
//  UIBarButtonItem.swift
//  Marsiple
//
//  Created by Matej Korman on 25/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func createCommentItem(target: Any, action: Selector) -> UIBarButtonItem {
        // TODO: - Localize
        return UIBarButtonItem(title: "Comment", style: .plain, target: target, action: action)
    }
}
