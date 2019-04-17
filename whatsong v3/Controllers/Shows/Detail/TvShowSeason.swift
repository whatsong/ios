//
//  TvShowSeason.swift
//  whatsong v3
//
//  Created by Tom Andrew on 16/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class TvShowSeason: BaseCvController, UICollectionViewDelegateFlowLayout, EpisodeCellDelegate  {
    
    let episodesCellId = "episodesCellId"

    var season: Seasons?
    var episodes: [TvShowEpisodes]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(Episodes.self, forCellWithReuseIdentifier: episodesCellId)
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
        if (season != nil) {
            fetchEpisodes()
        }
    }
    
    func fetchEpisodes()    {
        
        let urlString = "https://www.what-song.com/api/season-info?seasonID=\(season?._id ?? 0)"
        
        Service.shared.fetchTvShowSeason(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
            } else  {
                
                guard let seasonData = data?.data?.episodes else { return }
                print(seasonData)
                self.episodes = seasonData
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: episodesCellId, for: indexPath) as! Episodes
        cell.episodeCellDelegate = self
        cell.episodesArray = episodes
        cell.collectionView.reloadData()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat((self.episodes?.count ?? 0) * 70) + 50
        return CGSize(width: view.frame.width, height: height)
    }
    
    func didSelectEpisode(for episode: TvShowEpisodes)  {
        let episodeController = TvShowEpisode()
        episodeController.episode = episode
        episodeController.navigationItem.title = "Ep #\(episode.number) • \(episode.name)"
        self.navigationController?.pushViewController(episodeController, animated: true)
    }
}


