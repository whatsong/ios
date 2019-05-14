//
//  AlbumSongsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 14/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class AlbumSongsController: BaseCvController, UICollectionViewDelegateFlowLayout  {
    
    let albumSongListCellId = "albumSongListCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .red
        collectionView.register(AlbumSongList.self, forCellWithReuseIdentifier: albumSongListCellId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
}
