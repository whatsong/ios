//
//  ShowsCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 3/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ShowsGroupCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout  {
    
    var dayData: LatestShowsByDay?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "April 23rd", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        return label
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.attributedText = NSAttributedString(string: "Monday", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        return label
    }()
    
    var horizontalController = ShowsHorizontalController()
    
    func setupViews()   {
        
        backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        
        addSubview(dateLabel)
        addSubview(dayLabel)
        addSubview(horizontalController.view)
        
        dateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 30, bottom: 0, right: 0))
        
        dayLabel.anchor(top: dateLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 2, left: 30, bottom: 0, right: 0))
        
        horizontalController.view.anchor(top: dayLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
