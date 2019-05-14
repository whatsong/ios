//
//  AlbumSongsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 14/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class AlbumController: BaseCvController, UICollectionViewDelegateFlowLayout  {
    
    let albumSongListCellId = "albumSongListCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AlbumSongList.self, forCellWithReuseIdentifier: albumSongListCellId)
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumSongListCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
}
