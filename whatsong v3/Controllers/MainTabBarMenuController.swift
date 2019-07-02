//
//  MainTabBarMenuController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 2/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MainTabBarMenuContainerController: UIViewController, MainTabBarControllerDelegate    {
    
    var menuController: UIViewController!
    var centerTabBarController: UITabBarController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMainTabBarController()
        
    }
    
    func configureMainTabBarController()    {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.toggleMenuDelegate = self
        centerTabBarController = mainTabBarController
        
        view.addSubview(centerTabBarController.view)
        addChild(centerTabBarController)
        centerTabBarController.didMove(toParent: self)
    }
    
    func configureMenuController()  {
        if menuController == nil    {
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menuController")
        }
    }
    
    func showMenuController(shouldExpand: Bool)   {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerTabBarController.view.frame.origin.x = self.centerTabBarController.view.frame.width - 80
            }, completion: nil)
        }   else    {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerTabBarController.view.frame.origin.x = 0
            }, completion: nil)
        }
    }
    
    // Delegate method (toggleMenuDelegate)
    
    func handleMenuToggle() {
        if isExpanded == false  {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
}
