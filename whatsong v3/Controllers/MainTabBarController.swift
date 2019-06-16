//
//  MainTabBarController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController  {
    
    var profileController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userLoggedIn()  {
            setupLoggedInViewControllers()
        }   else    {
            setupLoggedOutViewControllers()
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    func setupLoggedInViewControllers() {
        viewControllers = [
            createNavController(viewController: MoviesController1(), title: "Movies", imageName: "movies-icon-text"),
            createNavController(viewController: ShowsController(), title: "TV Shows", imageName: "shows-icon-text"),
            createNavController(viewController: SearchController(), title: "Search", imageName: "search-icon-text"),
            createNavController(viewController: ProfileController(), title: "Profile", imageName: "profile-icon-text")
        ]
    }
    
    func setupLoggedOutViewControllers() {
        viewControllers = [
            createNavController(viewController: MoviesController(), title: "Movies", imageName: "movies-icon-text"),
            createNavController(viewController: ShowsController(), title: "TV Shows", imageName: "shows-icon-text"),
            createNavController(viewController: SearchController(), title: "Search", imageName: "search-icon-text"),
            createNavController(viewController: ProfileLoggedOutController(), title: "Profile", imageName: "profile-icon-text")
        ]
    }
    
    @objc func showLoginController()   {
        let loginController = OpenSwipingController()
        present(loginController, animated: true, completion: nil)
    }
    
    func userLoggedIn() -> Bool    {
        if DAKeychain.shared["accessToken"] != nil && (DAKeychain.shared["accessToken"]!).count > 0 {
            return true
        } else {
            return false
        }
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController  {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.title = title
        
        
        // I don't know what this line does!! For some reason though when I remove it, the ShowsController doesn't show anything.
        viewController.view.backgroundColor = UIColor.backgroundGrey()
        
        navController.tabBarItem.image = UIImage(named: imageName)
        //navController.tabBarItem.title = title
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        //tab bar attributes
        let tabBarAttributes: [NSAttributedString.Key: AnyObject] = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 10)!
            ]

        navController.tabBarItem.setTitleTextAttributes(tabBarAttributes, for: .normal)
        navController.tabBarController?.tabBar.isTranslucent = false
        
        //tab bar, remove line and set shadow
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowRadius = 3
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .brandBlack()
        self.tabBar.tintColor = .white
        
        // nav controller, remove line and set attributes
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.barTintColor = UIColor.backgroundGrey()
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.brandPurple()
        
        //back button
        let customFont = UIFont(name: "Montserrat-Regular", size: 14)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont!], for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 28)!,
            NSAttributedString.Key.kern: -0.6
        ]
        
        navController.navigationBar.largeTitleTextAttributes = attributes
        
        return navController
    }
}
