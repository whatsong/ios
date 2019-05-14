//
//  SoundtracksCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 9/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

protocol AlbumCellDelegate {
    func didSelectAlbum(for album: Album)
}

class AlbumsList: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var albumsArray: [Album] = []
    let cellId = "cellId"
    var albumCellDelegate: AlbumCellDelegate?
    
    let heading: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "Official Soundtrack Album", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier: cellId)
        
        backgroundColor = .clear
        
        addSubview(heading)
        addSubview(collectionView)
        
        heading.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 18, bottom: 0, right: 0))
        
        collectionView.anchor(top: heading.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AlbumCell
        let album = albumsArray[indexPath.item]
        let albumUrlString = URL(string: album.album.thumbnail ?? "")
        cell.albumImage.sd_setImage(with: albumUrlString, completed: nil)
        //cell.albumTitle.text = album.album.title
        cell.albumTitle.attributedText = NSAttributedString(string: album.album.title!, attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        cell.trackCount.text = "\(album.album.trackCount ?? "?") songs"
        cell.trackCount.attributedText = NSAttributedString(string: "\(album.album.trackCount ?? "?") songs", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if albumCellDelegate != nil {
            albumCellDelegate?.didSelectAlbum(for: albumsArray[indexPath.item])
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AlbumCell: UICollectionViewCell   {
    
    let albumImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "album-cover")
        iv.contentMode = .scaleToFill
        iv.constrainHeight(constant: 75)
        iv.constrainWidth(constant: 75)
        return iv
    }()
    
    let albumTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor.brandBlack()
        label.attributedText = NSAttributedString(string: "Shame (Official Motion Picture Soundtrack)", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let trackCount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "16 songs", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        let verticalStackView = VerticalStackView(arrangedSubviews: [albumTitle, trackCount])

        let stackView = UIStackView(arrangedSubviews: [albumImage, verticalStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 15

        addSubview(stackView)
        
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 18, bottom: 0, right: 18))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
