//
//  MainTabBarMenuController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 2/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class MainTabBarMenuContainerController: UIViewController, MainTabBarControllerDelegate, MFMailComposeViewControllerDelegate    {
    
    var menuController: MenuController!
    var centerTabBarController: UITabBarController!
    var isExpanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            configureMainTabBarController()
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation    {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool   {
        return isExpanded
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
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("Did add menuController")
        }
    }
    
    func showMenuController(shouldExpand: Bool, menuOption: MenuOption?)   {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerTabBarController.view.frame.origin.x = self.centerTabBarController.view.frame.width - 80
            }, completion: nil)
        }   else    {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerTabBarController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption)  {
        switch menuOption       {
            
        case .About:
            print("show about")
        case .ReportBug:
            showEmailComposer(subject: "Report Bug", bodyString: "Please outline the details of the bug below and one of our staff will review it ASAP. We appreciate you letting us know, so thanks")
        case .ReportListing:
            showEmailComposer(subject: "Report Listing", bodyString: "Please outline the details of the incorrect Listing below and one of our staff will review it ASAP. We appreciate you letting us know, so thanks")
        case .RequestMovie:
            showEmailComposer(subject: "Request Movie", bodyString: "Please leave the title and year of movie you are requesting below. One of our staff will do our best to get the movie uploaded within 24 hours. Thank you for your request")
        case .RequestShow:
            showEmailComposer(subject: "Request TV Show", bodyString: "Please leave the title and year of TV show you are requesting below. One of our staff will do our best to get the show uploaded within 24 hours. Thank you for your request")
        case .RequestFeature:
            showEmailComposer(subject: "Request Feature", bodyString: "WhatSong is managed by a very small team, however we do our best to communicate and action any and all of our user requests. Please leave a description of the feature you would love to see implemented into the app and we will get back to you within 24 hours.")
        case .VisitWebsite:
            showSafariVC(for: "https://www.what-song.com")
        case .Version:
            print("show about")
        }
    }
    
    func showEmailComposer(subject: String, bodyString: String)    {
        guard MFMailComposeViewController.canSendMail() else { return }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["staff@what-song.com"])
        composer.setSubject(subject)
        composer.setMessageBody(bodyString, isHTML: false)
        present(composer, animated: true, completion: nil)
    }
    
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    //MARK:-  Custom Delegate methods
    
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if isExpanded == false  {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded, menuOption: menuOption)
    }
    
    //MARK:- MFMail Delegate methods
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error    {
            dismiss(animated: true, completion: nil)
            return
        }
        
        switch result   {
        case .cancelled:
            print("cancelled")
        case .saved:
            print("saved")
        case .sent:
            showAlert(bgColor: UIColor.brandSuccess(), text: "Email sent successfully. We will reply in 24 hours :)")
        case .failed:
            print("Failed")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
