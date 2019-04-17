//
//  TvShowEpisode.swift
//  whatsong v3
//
//  Created by Tom Andrew on 17/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class TvShowEpisode: BaseCvController   {
    
    let songsCellId = "songsCellId"

    var episode: TvShowEpisodes?
    var songs: [Song]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: songsCellId)
        
        if (episode != nil) {
            fetchEpisode()
        }
    }
    
    func fetchEpisode() {
        let urlString = "https://www.what-song.com/api/episode-info?episodeID=\(episode?._id)"
        
        Service.shared.fetchTvShowEpisode(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
            } else  {
                
                guard let episodeData = data?.data else { return }
                print(episodeData)
                self.episode = episodeData.episode
                self.songs = episodeData.CompleteListOfSongs
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
}
