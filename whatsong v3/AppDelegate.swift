//
//  AppDelegate.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SPTSessionManagerDelegate {
   
    let SpotifyClientID = "e1e421b45f7e4356b886251e3284a583"
    let SpotifyRedirectURL = URL(string: "WhatSong://returnAfterLogin")!
    var session : SPTSession!
    lazy var configuration = SPTConfiguration(
        clientID: SpotifyClientID,
        redirectURL: SpotifyRedirectURL
    )
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://whatsong-soundtracks.herokuapp.com/api/token"),
            let tokenRefreshURL = URL(string: "https://whatsong-soundtracks.herokuapp.com/api/refresh_token") {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
            self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = MainTabBarMenuContainerController()

        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        sessionManager.application(app, open: url, options: options)
        return true
    }

    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
     
//        let alertController = UIAlertController(title: "isExpired : \(session.isExpired)", message: "Token:\n\(session.accessToken)", preferredStyle: .alert)
//      
//        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) {
//            UIAlertAction in
//            NSLog("Cancel Pressed")
//        }
//        alertController.addAction(cancelAction)
//        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        self.session = session
        
        // 5- Add session to User Defaults
        let userDefaults = UserDefaults.standard
        let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
        userDefaults.set(sessionData, forKey: "SPOTIFY_SESSION_DATA")
        userDefaults.synchronize()
        
        print("success", session.accessToken)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("fail", error)
    }
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        self.session = session
        // 5- Add session to User Defaults
        let userDefaults = UserDefaults.standard
        let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
        userDefaults.set(sessionData, forKey: "SPOTIFY_SESSION_DATA")
        userDefaults.synchronize()
        print("renewed", session)
    }
    
}

