//
//  MoviesGroupCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesGroupCell: UICollectionViewCell {
    
    var sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = .black
        label.attributedText = NSAttributedString(string: "Latest Releases", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        return label
    }()
    
    var horizontalController = MoviesHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(sectionLabel)
        addSubview(horizontalController.view)
        
        sectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        horizontalController.view.anchor(top: sectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
