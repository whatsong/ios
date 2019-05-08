//
//  SpotifyController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 8/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class SpotifyController: UIViewController   {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    @objc func clickSpotify() {
        print("click")
    }
    
    let loginSpotify: UIButton = {
        let button = UIButton()
        button.setTitle("Log in with Spotify", for: .normal)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clickSpotify), for: .touchUpInside)
        return button
    }()
    
    func setupViews()   {
        view.backgroundColor = .black
        
        view.addSubview(loginSpotify)
        
        loginSpotify.constrainWidth(constant: 150)
        loginSpotify.constrainHeight(constant: 50)
        loginSpotify.centerInSuperview()
        
    }
}

