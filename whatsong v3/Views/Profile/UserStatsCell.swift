//
//  UserStatsCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 27/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class UserStatsCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource   {
    
    let cellId = "cellId"
    
    var userStats: UserInfo?    {
        didSet  {
            fillArray()
        }
    }
    
    var labelArray = [String]()
    var countArray = [Int]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    
        setupViews()
    }
    
    func fillArray()    {
        labelArray = []
        countArray = []
        if let userStats = userStats {
            if userStats.scores != nil {
                labelArray.append("Songs")
                countArray.append(userStats.scores ?? 0)
            }
            if userStats.added_songs_count != nil {
                labelArray.append("Scene Descriptions")
                countArray.append(userStats.added_songs_count ?? 0)
            }
            if userStats.added_scenes_count != nil {
                labelArray.append("Time Descriptions")
                countArray.append(userStats.added_scenes_count ?? 0)
            }
        }
    }
    
    let contributionsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Contributions", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView =    {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func setupViews()   {
        collectionView.register(UserStatCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        addSubview(contributionsLabel)
        addSubview(collectionView)
        
        contributionsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        collectionView.anchor(top: contributionsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserStatCell
        cell.titleLabel.attributedText = NSAttributedString(string: "\(labelArray[indexPath.row])", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        cell.numberLabel.attributedText = NSAttributedString(string: "\(countArray[indexPath.row])", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width - 40, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UserStatCell: UICollectionViewCell    {
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Songs Added", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "1,304", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
    
        return label
    }()
    
    func setupViews()   {
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, numberLabel])
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(divider)

        stackView.fillSuperview()
        
        divider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        divider.constrainHeight(constant: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
