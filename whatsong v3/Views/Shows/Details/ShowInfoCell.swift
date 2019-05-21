//
//  ShowInfoCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 10/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ShowInfoCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource    {
    
    let cellId = "cellId"
    
    var showInfo: TvShowInfo? {
        didSet {
            fillHeaderArrayAndSubtitleArray()
        }
    }
    
    var headerArray = [String]()
    var subtitleArray = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews()   {
        
        collectionView.register(InfoSingleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        backgroundColor = .clear
        
        addSubview(topLine)
        addSubview(collectionView)
        addSubview(bottomLine)
        
        topLine.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        collectionView.anchor(top: topLine.bottomAnchor, leading: leadingAnchor, bottom: bottomLine.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        
        bottomLine.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))

    }
    
    func fillHeaderArrayAndSubtitleArray(){
        headerArray = []
        subtitleArray = []
        if let showInfo = showInfo {
            if showInfo.music_supervisor != nil {
                headerArray.append("Music Supervisor")
                subtitleArray.append(showInfo.music_supervisor!)
            }
            if showInfo.song_count != nil {
                headerArray.append("# of Songs")
                subtitleArray.append("\(showInfo.song_count!)")
            }
            if showInfo.network != nil {
                headerArray.append("Network")
                subtitleArray.append(showInfo.network!)
            }
            if showInfo.composer != nil {
                headerArray.append("Composer")
                subtitleArray.append(showInfo.composer!)
            }
        }
        collectionView.reloadData()
    }
    
    let topLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 229/255, alpha: 1)
        view.constrainHeight(constant: 1)
        return view
    }()
    
    let bottomLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 229/255, alpha: 1)
        view.constrainHeight(constant: 1)
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoSingleCell
        cell.headingLabel.text = headerArray[indexPath.row]
        cell.secondaryLabel.text = subtitleArray[indexPath.row]
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label = UILabel()
        if headerArray[indexPath.row].count > subtitleArray[indexPath.row].count {
           label.text = headerArray[indexPath.row]
        } else {
            label.text = subtitleArray[indexPath.row]
        }
        let labelWidth = label.intrinsicContentSize.width
        return CGSize(width: labelWidth + 35, height: 38)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InfoSingleCell: UICollectionViewCell  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    func setupViews()   {
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [headingLabel, secondaryLabel])
        
        addSubview(verticalStackView)
        addSubview(verticalDivider)
        
        verticalStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: verticalDivider.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        verticalStackView.centerYInSuperview()
        
        verticalDivider.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 1))
        
    }
    
    var headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Music Supervisor"
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Music Supervisor"
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let verticalDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 229/255, alpha: 1)
        view.constrainWidth(constant: 1)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
