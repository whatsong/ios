//
//  LibrarySongsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 31/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LibrarySongsController: BaseCvController, UICollectionViewDelegateFlowLayout, SongCellDelegate  {
    
    private var songListCellId = "songListCellId"
    private var userSongs: [Song] = []
    var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(LibrarySongs.self, forCellWithReuseIdentifier: songListCellId)
        collectionView.backgroundColor = UIColor.backgroundGrey()
        fetchSongs()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchSongs), name: .wsNotificationLikeSong, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func fetchSongs() {
        userSongs = []
        collectionView.reloadData()
        startActivityIndicator(center:  CGPoint(x: self.view.bounds.midX, y: 100))
        var urlString = "https://www.what-song.com/api/list-of-songs-favorited?username="
        if let userInfo = userInfo, let username = userInfo.username {
            urlString = "\(urlString)\(username)"
        }
        Service.shared.fetchCurrentUserSongs(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
                self.stopActivityIndicator()
            } else  {
                guard let userLibraryData = data else { return }
                self.userSongs = userLibraryData.data
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: songListCellId, for: indexPath) as! LibrarySongs

        cell.songsArray = self.userSongs
        cell.songCellDelegate = self
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat((self.userSongs.count) * 60) + 100
        return CGSize(width: view.frame.width, height: height)
    }
    
    func didSelectSongDetail(for song: Song) {
        let songDetailController = SongDetailPopupController()
        songDetailController.song = song
        songDetailController.navigationItem.title = song.title
        self.navigationController?.present(songDetailController, animated: true, completion: nil)
    }
}
