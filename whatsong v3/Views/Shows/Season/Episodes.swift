//
//  Episodes.swift
//  whatsong v3
//
//  Created by Tom Andrew on 16/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

protocol EpisodeCellDelegate {
    func didSelectEpisode(for episode: TvShowEpisodes)
}

class Episodes: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout    {
    
    let cellId = "cellId"
    
    var episodesArray: [TvShowEpisodes]? = []
    var episodeCellDelegate: EpisodeCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Episodes"
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
        backgroundColor = UIColor.backgroundGrey()
        
        collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(headingLabel)
        addSubview(collectionView)
        
        headingLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        collectionView.anchor(top: headingLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodesArray?[indexPath.item]
        
        cell.episodeLabel.text = "#\(episode?.number ?? 0) • \(episode?.name ?? "")"
        cell.songCountLabel.text = "\(episode?.songs_count ?? 0) songs"
        
        let timeStamp = Double(episode?.date_released ?? 0) / 1000
        let date = Date(timeIntervalSince1970: timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)


        cell.dateLabel.text = strDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if episodeCellDelegate != nil {
            episodeCellDelegate?.didSelectEpisode(for: (episodesArray?[indexPath.item])!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EpisodeCell: UICollectionViewCell {
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
    
    var episodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Season One"
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "15th Jan, 2019"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var songCountLabel: UILabel = {
        let label = UILabel()
        label.text = "12 songs"
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews()   {
        backgroundColor = .clear
        
        let stackView = VerticalStackView(arrangedSubviews: [episodeLabel, dateLabel], spacing: 2)
        let horizontalStackView = UIStackView(arrangedSubviews: [stackView, songCountLabel])
        horizontalStackView.spacing = 8
        
        addSubview(bgView)
        addSubview(dividerLine)
        addSubview(horizontalStackView)
        
        bgView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        dividerLine.anchor(top: nil, leading: bgView.leadingAnchor, bottom: bgView.bottomAnchor, trailing: bgView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        horizontalStackView.anchor(top: nil, leading: bgView.leadingAnchor, bottom: nil, trailing: bgView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        horizontalStackView.centerYInSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
