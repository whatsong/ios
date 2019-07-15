//
//  LibrarySongsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 31/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LibrarySongsController: BaseCvController, UICollectionViewDelegateFlowLayout, SongCellDelegate,SongDetailPopupControllerDelegate  {
    
    private var songListCellId = "songListCellId"
    private var userSongs: [Song] = []
    var userInfo: UserInfo?
    var currentPage: Int = 1
    var isDataFound = true
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
        if(self.currentPage == 1){
            userSongs = []
            collectionView.reloadData()
            startActivityIndicator(center:  CGPoint(x: self.view.bounds.midX, y: 100))
        }
        var urlString = "https://www.what-song.com/api/list-of-songs-favorited?username="
        if let userInfo = userInfo, let username = userInfo.username {
            urlString = "\(urlString)\(username)"
        }
        urlString = "\(urlString)&page=\(currentPage)"
        Service.shared.fetchCurrentUserSongs(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
                self.stopActivityIndicator()
            } else  {
                guard let userLibraryData = data else { return }
                if(self.currentPage == 1){
                    self.userSongs.removeAll()
                    self.userSongs = userLibraryData.data
                    if(self.userSongs.count < 10){
                        self.isDataFound = false
                    }
                }
                else{
                    for objSongs in userLibraryData.data{
                        let index =  self.userSongs.firstIndex(where: { (obj) -> Bool in
                            obj._id == objSongs._id
                        })
                        if(index != nil){
                            self.userSongs.remove(at: index!)
                            self.userSongs.insert(objSongs, at: index!)
                        }
                        else{
                            self.userSongs.append(objSongs)
                        }
                    }
                    if(userLibraryData.data.count < 1){
                        self.isDataFound = false
                    }
                }
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
        cell.vc = self
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
        songDetailController.delegate = self
        songDetailController.navigationItem.title = song.title
        self.navigationController?.present(songDetailController, animated: true, completion: nil)
    }
    
    // ScrollViewDelegate
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let threhold = maximumOffset - currentOffset
        if threhold <= 10 && isDataFound {
            self.currentPage += 1
            fetchSongs()
        }
    }
    func refreshDetailViewScene() {
        fetchSongs()
    }
}
