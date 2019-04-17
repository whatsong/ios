//
//  SeasonsList.swift
//  whatsong v3
//
//  Created by Tom Andrew on 15/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

protocol SeasonCellDelegate {
    func didSelectSeason(for season: Seasons)
}

class SeasonsList: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var seasonsArray: [Seasons] = []
    var seasonCellDelegate: SeasonCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Seasons"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func setupViews()   {
        
        collectionView.register(SeasonCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
                
        addSubview(headingLabel)
        addSubview(collectionView)
        
        headingLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 20, bottom: 0, right: 0))
        collectionView.anchor(top: headingLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SeasonCell
        let item = seasonsArray[indexPath.item]
        cell.seasonLabel.text = "Season \(item.season)"
        cell.songCountLabel.text = "\(item.songs_count ?? 0) songs"
        cell.episodeCountLabel.text = "\(item.episodes_count ?? 0) episodes"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {        
        if seasonCellDelegate != nil {
            seasonCellDelegate?.didSelectSeason(for: seasonsArray[indexPath.item])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SeasonCell: UICollectionViewCell  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGrey()
        view.constrainHeight(constant: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var seasonLabel: UILabel = {
        let label = UILabel()
        label.text = "Season One"
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songCountLabel: UILabel = {
        let label = UILabel()
        label.text = "192 songs"
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let interItem: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var episodeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "13 episodes"
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews()   {
        
        backgroundColor = .clear
        
        addSubview(bgView)
        addSubview(dividerLine)
        addSubview(seasonLabel)
        addSubview(songCountLabel)
        addSubview(interItem)
        addSubview(episodeCountLabel)
        
        
        bgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: dividerLine.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        dividerLine.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        seasonLabel.anchor(top: nil, leading: bgView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        seasonLabel.centerYInSuperview()
        
        songCountLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: bgView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        songCountLabel.centerYInSuperview()
        
        interItem.anchor(top: nil, leading: nil, bottom: nil, trailing: songCountLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 4))
        interItem.centerYInSuperview()
        
        episodeCountLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: interItem.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 4))
        episodeCountLabel.centerYInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
