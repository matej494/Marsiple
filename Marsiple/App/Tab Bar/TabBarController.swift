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
        let navigationController = UINavigationController(rootViewController: PostsViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = MatrianColor.gray.value
        tabBar.barTintColor = MatrianColor.dark.value
        tabBar.tintColor = .white
        viewControllers = [navigationController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
