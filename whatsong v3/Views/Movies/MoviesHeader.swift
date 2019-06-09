//
//  MoviesHeader.swift
//  whatsong v3
//
//  Created by Tom Andrew on 26/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesHeader: UICollectionReusableView    {
    
    let moviesHeaderHorizontalController = MoviesHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(moviesHeaderHorizontalController.view)
        moviesHeaderHorizontalController.view.fillSuperview()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoviesHeaderCell: UICollectionViewCell    {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setupViews()
        
    }
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 229/255, alpha: 1)
        view.constrainHeight(constant: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let featuredLabel: UILabel = {
        let label = UILabel()
        label.text = "FEATURED"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandPurple()
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.attributedText = NSAttributedString(string: "John Wick 3: Parabellum", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.textColor = UIColor.brandBlack()
        return label
    }()
    
    let songCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.attributedText = NSAttributedString(string: "14 songs", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.textColor = UIColor.brandLightGrey()
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.brandLightGrey()
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    func setupViews()   {
        let stackView = VerticalStackView(arrangedSubviews: [divider, featuredLabel, titleLabel, songCountLabel, imageView], spacing: 1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(6, after: divider)
        stackView.setCustomSpacing(6, after: songCountLabel)
        
        addSubview(stackView)
        
        stackView.fillSuperview(padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
