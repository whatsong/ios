//
//  TvShowEpisode.swift
//  whatsong v3
//
//  Created by Tom Andrew on 17/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class TvShowEpisode: BaseCvController, UICollectionViewDelegateFlowLayout   {
    
    let songsCellId = "episodeCellId"
    
    var episode: TvShowEpisodes?
    var songs: [Song] = []
    
    let heightOfSongs = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        collectionView.register(SongListCell.self, forCellWithReuseIdentifier: songsCellId)
        
        if (episode != nil) {
            fetchEpisode()
        }
    }
    
    func fetchEpisode() {
        let urlString = "https://www.what-song.com/api/episode-info?episodeID=\(episode?._id ?? 0)"
        
        Service.shared.fetchTvShowEpisode(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
            } else  {
                
                guard let episodeData = data?.data else { return }
                self.songs = episodeData.CompleteListOfSongs
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: songsCellId, for: indexPath) as! SongListCell
        cell.songsArray = songs
        cell.collectionView.reloadData()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(songs.count * heightOfSongs) + 50)
    }
}
