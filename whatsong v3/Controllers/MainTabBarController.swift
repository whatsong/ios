//
//  MainTabBarController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        viewControllers = [
            createNavController(viewController: MoviesController(), title: "Movies", imageName: "apps"),
            createNavController(viewController: UIViewController(), title: "Shows", imageName: "today_icon"),
            createNavController(viewController: SearchController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController  {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
}
