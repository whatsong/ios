//
//  LibrarySongsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 31/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LibrarySongsController: BaseCvController, UICollectionViewDelegateFlowLayout  {
    
    var songListCellId = "songListCellId"
    var userSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(LibrarySongs.self, forCellWithReuseIdentifier: songListCellId)
        collectionView.backgroundColor = UIColor.backgroundGrey()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: songListCellId, for: indexPath) as! LibrarySongs
        cell.songsArray = self.userSongs
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat((self.userSongs.count) * 60) + 100
        return CGSize(width: view.frame.width, height: height)
    }
}
