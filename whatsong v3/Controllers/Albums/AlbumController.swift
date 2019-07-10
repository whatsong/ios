//
//  AlbumSongsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 14/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class AlbumController: BaseCvController, UICollectionViewDelegateFlowLayout, SongCellDelegate,SongDetailPopupControllerDelegate  {
    
    let albumSongListCellId = "albumSongListCellId"
    var albumSongs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AlbumSongList.self, forCellWithReuseIdentifier: albumSongListCellId)
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumSongListCellId, for: indexPath) as! AlbumSongList
        cell.songsArray = self.albumSongs
        cell.songCellDelegate = self
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat((self.albumSongs.count) * 60) + 100
        return CGSize(width: view.frame.width, height: height)
    }
    
    func didSelectSongDetail(for song: Song)  {
        let songDetailController = SongDetailPopupController()
        songDetailController.song = song
        songDetailController.delegate = self
        songDetailController.navigationItem.title = song.title
        self.navigationController?.present(songDetailController, animated: true, completion: nil)
    }
    func refreshDetailScence() {
        
    }
}
