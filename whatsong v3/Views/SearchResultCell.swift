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
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 67).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 100).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "American Beauty"
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2001"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, yearLabel])
        verticalStackView.axis = .vertical
        
        let horizontalStackView = UIStackView(arrangedSubviews: [posterImageView, verticalStackView])
        horizontalStackView.spacing = 12
        horizontalStackView.alignment = .center
        
        addSubview(horizontalStackView)
        horizontalStackView.fillSuperview(padding: .init(top: 12, left: 20, bottom: 12, right: 20))
      
        backgroundColor = .green
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
