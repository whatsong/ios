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
            createNavController(viewController: MoviesController(), title: "Movies", imageName: "movies-icon-no-text"),
            createNavController(viewController: ShowsController(), title: "TV Shows", imageName: "tv-icon-no-text"),
            createNavController(viewController: SearchController(), title: "Search", imageName: "search-icon-no-text"),
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController  {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        
        // I don't know what this line does!! For some reason though when I remove it, the ShowsController doesn't show anything.
        viewController.view.backgroundColor = UIColor.backgroundGrey()
        
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.title = title
        
        let tabBarAttributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 10)!
            ]

        navController.tabBarItem.setTitleTextAttributes(tabBarAttributes, for: .normal)
        navController.tabBarController?.tabBar.isTranslucent = false
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.barTintColor = UIColor.backgroundGrey()
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.brandPurple()
        
        //back button
        let customFont = UIFont(name: "Montserrat-Regular", size: 14)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont!], for: .normal)
        
        let attributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 28)!
        ]
        
        navController.navigationBar.largeTitleTextAttributes = attributes
        
        return navController
    }
}
