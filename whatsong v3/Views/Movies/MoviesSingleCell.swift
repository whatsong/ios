//
//  MoviesRowCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 6/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesSingleCell: UICollectionViewCell   {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.7
        view.isSkeletonable = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.brandLightGrey()
        iv.constrainWidth(constant: 120)
        iv.constrainHeight(constant: 160)
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        iv.isSkeletonable = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel = UILabel(text: "American Psycho", font: UIFont(name: "Montserrat-Regular", size: 12)!, color: UIColor.brandBlack())
    
    let songCountLabel = UILabel(text: "12 songs", font: UIFont(name: "Montserrat-Regular", size: 10)!, color: UIColor.brandPurple())
    let yearLabel = UILabel(text: "1999", font: UIFont(name: "Montserrat-Light", size: 10)!, color: UIColor.brandLightGrey())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 1
        
        
        addSubview(bgView)
        addSubview(imageView)
        
        bgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        bgView.constrainWidth(constant: 120)
        
        imageView.anchor(top: bgView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, songCountLabel, yearLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        
        addSubview(stackView)
        stackView.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 6, left: 8, bottom: 6, right: 8))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
