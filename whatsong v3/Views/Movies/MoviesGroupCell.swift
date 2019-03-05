//
//  MoviesGroupCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension UILabel   {
    convenience init(text: String, font: UIFont, color: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
    }
}

class MoviesGroupCell: UICollectionViewCell {
    
    let sectionLabel = UILabel(text: "Heading", font: UIFont(name: "Montserrat-Regular", size: 22)!, color: UIColor.brandDarkGrey())
    
    let horizontalController = MoviesHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.purple
        horizontalController.view.backgroundColor = .blue
        
        addSubview(sectionLabel)
        addSubview(horizontalController.view)
        
        sectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        horizontalController.view.anchor(top: sectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
