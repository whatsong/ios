//
//  SearchCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell  {
    
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.brandLightGrey()
        iv.widthAnchor.constraint(equalToConstant: 51).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 76).isActive = true
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.image = UIImage(named: "movie-poster")
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor.brandBlack()
        label.attributedText = NSAttributedString(string: "Placeholder", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.brandLightGrey()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.attributedText = NSAttributedString(string: "2019", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, yearLabel])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 2
        
        let horizontalStackView = UIStackView(arrangedSubviews: [posterImageView, verticalStackView])
        horizontalStackView.spacing = 16
        horizontalStackView.alignment = .center
        
        addSubview(horizontalStackView)
        horizontalStackView.fillSuperview(padding: .init(top: 12, left: 20, bottom: 12, right: 20))
      
        backgroundColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
