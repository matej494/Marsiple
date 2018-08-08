//
//  UIAlertController-Marsiple.swift
//  Marsiple
//
//  Created by Matej Korman on 27/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func alertStyle(title: String?, message: String?, cancelActionTitle: String?, cancelActionHandler: ((UIAlertAction) -> Void)?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelActionTitle, style: .cancel, handler: cancelActionHandler))
        return alert
    }
}
