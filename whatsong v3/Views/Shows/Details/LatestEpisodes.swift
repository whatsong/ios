//
//  LatestEpisodes.swift
//  whatsong v3
//
//  Created by Tom Andrew on 11/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

protocol LatestEpisodeCellDelegate {
    func didSelectLatestEpisode(for episode: TvShowEpisodes)
}

class LatestEpisodes: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    let cellId = "cellId"
    var latestEpisodes: [TvShowEpisodes] = []
    var latestEpisodeCellDelegate: LatestEpisodeCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    let collectionView: UICollectionView =    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.isScrollEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    func setupViews()   {
        
        backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LatestEpisode.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestEpisodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LatestEpisode
        let episode = latestEpisodes[indexPath.item]
        //cell.episodeLabel.text = String(episode._id)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if latestEpisodeCellDelegate != nil {
            latestEpisodeCellDelegate?.didSelectLatestEpisode(for: (latestEpisodes[indexPath.item]))
            print(latestEpisodes[indexPath.item])
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LatestEpisode: UICollectionViewCell   {
    
    let episodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Jump to Latest Episode"
        label.attributedText = NSAttributedString(string: "Jump to Latest Episode", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.backgroundColor = UIColor(red: 121/255, green: 6/255, blue: 255/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(episodeLabel)
        
        episodeLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20))
        
        backgroundColor = .clear
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
