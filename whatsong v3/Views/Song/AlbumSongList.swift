//
//  AlbumSongList.swift
//  whatsong v3
//
//  Created by Tom Andrew on 14/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class AlbumSongList: SongListCell   {
    
    let albumSongId = "albumSongId"

    override func setupViews() {
        
        collectionView.register(AlbumSongCell.self, forCellWithReuseIdentifier: albumSongId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        addSubview(heading)
        addSubview(collectionView)
        
        heading.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 18, bottom: 0, right: 0))
        
        collectionView.anchor(top: heading.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        songsArray = songsArray.sorted(by: { (firstSong, secondSong) -> Bool in
            guard let trackNumber0 = firstSong.track_number, let trackNumber1 = secondSong.track_number else { return false }
            return trackNumber0 < trackNumber1
        })

        
        return songsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumSongId, for: indexPath) as! AlbumSongCell
        cell.backgroundColor = .white
        let song = songsArray[indexPath.item]
        cell.trackNumber.text = "\(song.track_number ?? 0)."
        cell.songTitle.attributedText = NSAttributedString(string: song.title, attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        cell.artistName.attributedText = NSAttributedString(string: song.artist.name, attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        
        let moreButtonTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreButtonTap))
        cell.moreButton.isUserInteractionEnabled = true
        cell.moreButton.addGestureRecognizer(moreButtonTapRecognizer)
        
        return cell
    }
}

class AlbumSongCell: SongCell   {
    
    let trackNumber: UILabel = {
        let label = UILabel()
        label.text = "#1"
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.textAlignment = .center
        label.constrainWidth(constant: 24)
        return label
    }()
    
    let albumArtistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "Kairos", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews()   {
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [songTitle, albumArtistName])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 3
        
        let stackView = UIStackView(arrangedSubviews: [trackNumber, verticalStackView, moreButton])
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(divider)
        
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 18, bottom: 0, right: 18))
        divider.anchor(top: nil, leading: leadingAnchor, bottom: stackView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        divider.constrainHeight(constant: 1)
    }
}
