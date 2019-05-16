//
//  SwipedPageCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 16/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class SwipedPageCell: UICollectionViewCell  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        backgroundColor = .backgroundGrey()
        
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo-with-text")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.constrainHeight(constant: 100)
        iv.constrainWidth(constant: 196)
        return iv
    }()
    
    let subheading: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Find music from the latest movies and television shows", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandLightGrey()
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews()   {
        
        addSubview(imageView)
        addSubview(subheading)
        
        imageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 200, left: 0, bottom: 0, right: 0))
        imageView.centerXInSuperview()
        
        subheading.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 40, left: 60, bottom: 0, right: 60))
        subheading.centerXInSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
