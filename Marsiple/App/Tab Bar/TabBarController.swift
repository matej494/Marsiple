//
//  TabBarController.swift
//  Marsiple
//
//  Created by Matej Korman on 16/07/2018.
//  Copyright © 2018 Matej Korman. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        let viewControllerList = [PostsViewController(), AlbumsViewController()]
        tabBar.barTintColor = .martianDark
        tabBar.tintColor = .white
        viewControllers = viewControllerList.map {
            let navigationController = UINavigationController(rootViewController: $0)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barTintColor = .martianGrey
            return navigationController
        }
    }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
