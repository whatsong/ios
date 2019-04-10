//
//  MoviesRowCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 6/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesSingleCell: UICollectionViewCell   {
    
    let imageView = UIImageView(cornerRadius: 8)
    let titleLabel = UILabel(text: "American Psycho", font: UIFont(name: "Montserrat-Regular", size: 18)!, color: UIColor.brandDarkGrey())
    
    let yearLabel = UILabel(text: "1999", font: UIFont(name: "Montserrat-Regular", size: 16)!, color: UIColor.brandLightGrey())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 80)
        imageView.constrainHeight(constant: 114)
        imageView.backgroundColor = .red
        
        titleLabel.numberOfLines = 0
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, yearLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 2
        
        let stackView = UIStackView(arrangedSubviews: [imageView, verticalStackView])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
