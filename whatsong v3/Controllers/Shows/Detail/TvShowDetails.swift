//
//  TvShow.swift
//  whatsong v3
//
//  Created by Tom Andrew on 9/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class TvShowDetailsController: BaseCvController, UICollectionViewDelegateFlowLayout, SeasonCellDelegate, LatestEpisodeCellDelegate    {
    
    let infoCellId = "cellId"
    let latestEpisodeCellId = "latestEpisodesCellId"
    let seasonsCellId = "seasonsCellId"
    
    var tvShowInfo: TvShowInfo?
    var popularSongs: [TvPopularSongs]? = []
    var seasons: [Seasons] = []
    var latestEpisodes: [TvShowEpisodes] = []
    
    var showId: Int!    {
        didSet {
            startActivityIndicator(center: CGPoint(x: self.view.bounds.midX, y: 100))
            let urlString = "https://www.what-song.com/api/tv-info?tvshowID=\(showId ?? 0)"
            Service.shared.fetchTvShowDetail(urlString: urlString) { (data, err) in
                
                if let err = err {
                    print(err)
                } else  {
                    
                    guard let tvData = data?.data else { return }
                    self.tvShowInfo = tvData.tv_show
                    self.seasons = tvData.seasons
                    self.latestEpisodes = tvData.last_episodes
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.stopActivityIndicator()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView.register(ShowInfoCell.self, forCellWithReuseIdentifier: infoCellId)
        collectionView?.register(LatestEpisodes.self, forCellWithReuseIdentifier: latestEpisodeCellId)
        collectionView?.register(SeasonsList.self, forCellWithReuseIdentifier: seasonsCellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! ShowInfoCell
            cell.showInfo = tvShowInfo
            cell.collectionView.reloadData()
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: latestEpisodeCellId, for: indexPath) as! LatestEpisodes
            cell.latestEpisodes = latestEpisodes
            cell.latestEpisodeCellDelegate = self
            cell.collectionView.reloadData()
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: seasonsCellId, for: indexPath) as! SeasonsList
        cell.seasonsArray = seasons
        cell.seasonCellDelegate = self
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0  {
            return CGSize(width: view.frame.width, height: 68)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: 80)
        }
        let height = CGFloat((self.seasons.count) * 60) + 50
        return CGSize(width: view.frame.width, height: height)
    }
    
    func didSelectSeason(for season: Seasons)  {
        let seasonsController = TvShowSeason()
        seasonsController.season = season
        seasonsController.navigationItem.title = "Season \(season.season)"
        self.navigationController?.pushViewController(seasonsController, animated: true)
    }
    
    func didSelectLatestEpisode(for episode: TvShowEpisodes)  {
        let episodeController = TvShowEpisode()
        episodeController.episode = episode
        episodeController.navigationItem.title = "Ep #\(episode.number) • \(episode.name)"
        self.navigationController?.pushViewController(episodeController, animated: true)
    }
}
