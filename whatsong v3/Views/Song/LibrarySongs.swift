//
//  LibraryCells.swift
//  whatsong v3
//
//  Created by Tom Andrew on 31/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LibrarySongs: SongListCell    {
    
    let librarySongId = "librarySongId"
    let loadingCellId = "loadingCellId"
    var vc : LibrarySongsController! = nil

    override func setupViews() {
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: loadingCellId)
        collectionView.register(LibrarySongCell.self, forCellWithReuseIdentifier: librarySongId)
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
        if(indexPath.row == (self.songsArray.count - 1) && self.vc.isDataFound){
            return CGSize(width: frame.width, height: 44)
        }
        else{
           return CGSize(width: frame.width, height: 60)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songsArray.count + (self.vc.isDataFound ? 1 : 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == self.songsArray.count && self.vc.isDataFound){
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadingCellId, for: indexPath) as! LoadingCell
            cell.activityIndicatorView.startAnimating()
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: librarySongId, for: indexPath) as! LibrarySongCell
        cell.backgroundColor = .white
        let song = songsArray[indexPath.item]
        cell.songTitle.attributedText = NSAttributedString(string: "", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        cell.artistName.attributedText = NSAttributedString(string: "", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
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

class LibrarySongCell: SongCell {
    
    override func setupViews()   {
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [songTitle, artistName])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 3
        
        let stackView = UIStackView(arrangedSubviews: [verticalStackView, moreButton])
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
