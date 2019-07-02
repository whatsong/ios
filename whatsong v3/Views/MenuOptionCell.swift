//
//  MenuOptionCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 2/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell   {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        titleLabel.centerYInSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
