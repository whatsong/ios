//
//  ProfileLoggedOutController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 28/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ProfileLoggedOutController: UIViewController  {
    
    func setupViews()   {
        self.tabBarController?.tabBar.isHidden = true
        
        let stackView = VerticalStackView(arrangedSubviews: [headingLabel, featureOne, featureTwo, featureThree, button], spacing: 8)
        stackView.setCustomSpacing(18, after: headingLabel)
        stackView.setCustomSpacing(24, after: featureThree)
        
        view.addSubview(stackView)
        
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 30, right: 20))
        
    }
    
    let headingLabel: UILabel = {
        let label = UILabel()
        let string = "Sign up or login to access the following features for free"
        label.attributedText = NSAttributedString(string: string, attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.numberOfLines = 2
        label.textColor = UIColor.brandBlack()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        return label
    }()
    
    let featureOne: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "• Save your favourite songs", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.textColor = UIColor.brandLightGrey()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
    let featureTwo: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "• Edit scene descriptions", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.textColor = UIColor.brandLightGrey()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
    let featureThree: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "• Personalise profile page to manage your contributions, progress and library", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.textColor = UIColor.brandLightGrey()
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 18)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor.brandLightPink()
        button.layer.cornerRadius = 6
        button.constrainHeight(constant: 50)
        button.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        return button
    }()
    
    @objc func getStarted() {
        print("start")
        present(OpenSwipingController(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()

    }
}
