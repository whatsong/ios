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
            createNavController(viewController: ShowsController(), title: "TV Shows", imageName: "today_icon"),
            createNavController(viewController: SearchController(), title: "Search", imageName: "search")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController  {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        
        // I don't know what this line does!! For some reason though when I remove it, the ShowsController doesn't show anything.
        viewController.view.backgroundColor = UIColor.black
        
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.title = title
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isTranslucent = false
        
        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 28)!
        ]
        
        navController.navigationBar.largeTitleTextAttributes = attributes
        
        return navController
    }
}
