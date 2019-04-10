//
//  ShowsSingleCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ShowsSingleCell: UICollectionViewCell {
    
    var tvShow: ShowDetails?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowOpacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "movie-poster")
        iv.contentMode = .scaleAspectFill
        iv.constrainHeight(constant: 160)
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandBlack()
        label.attributedText = NSAttributedString(string: "Stranger Things", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        return label
    }()
    
    var songCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 10)
        label.textColor = UIColor.brandBlue()
        label.attributedText = NSAttributedString(string: "5 songs", attributes: [
            NSAttributedString.Key.kern: -0.3
            ])
        return label
    }()
    
    var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 10)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "s01 • e04", attributes: [
            NSAttributedString.Key.kern: -0.3
            ])
        return label
    }()
    
    func setupViews()   {
        
        backgroundColor = .clear
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, songCountLabel, episodeLabel])
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        
        addSubview(bgView)
        addSubview(posterImageView)
        addSubview(stackView)
        
        bgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        
        posterImageView.anchor(top: bgView.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        stackView.anchor(top: posterImageView.bottomAnchor, leading: leadingAnchor, bottom: bgView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 6, left: 8, bottom: 6, right: 8))
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
