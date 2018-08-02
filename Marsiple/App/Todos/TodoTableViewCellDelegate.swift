//
//  TodoTableViewCellDelegate.swift
//  Marsiple
//
//  Created by Matej Korman on 01/08/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

protocol TodoTableViewCellDelegate: class {
    func tableViewCell(didSelectTitleAt indexPath: IndexPath)
    func tableViewCell(didSelectCheckBoxAt indexPath: IndexPath)
}
