//
//  LatestEpisodes.swift
//  whatsong v3
//
//  Created by Tom Andrew on 11/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LatestEpisodes: UICollectionViewCell  {
    
    var latestEpisodes: [LatestEpisodes]? = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    let latestEpisodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Jump to Latest Episode", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(red: 121/255, green: 6/255, blue: 255/255, alpha: 1    )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews()   {
        
        backgroundColor = UIColor.clear
        
        addSubview(latestEpisodeButton)
        
        latestEpisodeButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 15, left: 20, bottom: 15, right: 20))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
