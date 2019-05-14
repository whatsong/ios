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
        
        collectionView.register(AlbumSong.self, forCellWithReuseIdentifier: albumSongId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .gray
        
        addSubview(heading)
        addSubview(collectionView)
        
        heading.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 18, bottom: 0, right: 0))
        
        collectionView.anchor(top: heading.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumSongId, for: indexPath) as! AlbumSong
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("album song picked")
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

class AlbumSong: UICollectionViewCell   {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
