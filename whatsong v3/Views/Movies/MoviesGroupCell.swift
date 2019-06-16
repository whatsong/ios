//
//  MoviesGroupCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesGroupCell: UICollectionViewCell {
    
    var dayData: MoviesByScheduleByDay?
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "April 23rd", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        return label
    }()
    
    var sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.attributedText = NSAttributedString(string: "Latest Releases", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        return label
    }()
    
    var horizontalController = MoviesHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateLabel)
        addSubview(sectionLabel)
        addSubview(horizontalController.view)
        
        dateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        sectionLabel.anchor(top: dateLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 20, bottom: 0, right: 0))
        horizontalController.view.anchor(top: sectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
