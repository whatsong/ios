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
        
        backgroundColor = UIColor.backgroundGrey()
    }
    
    let imageScreenshot: UIImageViewAligned = {
        let iv = UIImageViewAligned()
        iv.alignTop = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let logoText: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "whatsong", attributes: [
            NSAttributedString.Key.kern: -1.0
            ])
        label.font = UIFont(name: "FatFrank", size: 40)
        label.textColor = UIColor(red: 41/255, green: 45/255, blue: 51/255, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let subheading: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Discover music from the latest movies and television shows", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        label.textColor = UIColor(red: 41/255, green: 45/255, blue: 51/255, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    func setupViews(distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, spacing: CGFloat)   {
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [imageScreenshot, logoText, subheading])
        verticalStackView.spacing = spacing
        verticalStackView.distribution = distribution
        verticalStackView.alignment = alignment
        verticalStackView.setCustomSpacing(20, after: imageScreenshot)

        addSubview(verticalStackView)
        
        verticalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 10, right: 20))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
