//
//  TvShowEpisode.swift
//  whatsong v3
//
//  Created by Tom Andrew on 17/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class TvShowEpisode: BaseCvController, UICollectionViewDelegateFlowLayout, SongCellDelegate,SongDetailPopupControllerDelegate   {
    
    let songsCellId = "episodeCellId"
    let infoCellId = "infoCellId"
    
    var episode: TvShowEpisodes?
    var songs: [Song] = []
    
    
    let heightOfSongs = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        collectionView.register(EpisodeInfoCell.self, forCellWithReuseIdentifier: infoCellId)
        collectionView.register(SongListCell.self, forCellWithReuseIdentifier: songsCellId)
        
        //setupRightBarButtonItem()
        
        if (episode != nil) {
            fetchEpisode()
        }
    }
    
    func fetchEpisode() {
        startActivityIndicator(center: CGPoint(x: self.view.bounds.midX, y: 100))
        let urlString = "https://www.what-song.com/api/episode-info?episodeID=\(episode?._id ?? 0)"
        Service.shared.fetchTvShowEpisode(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
            } else  {
                
                guard let episodeData = data?.data else { return }
                self.songs = episodeData.CompleteListOfSongs
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.stopActivityIndicator()
                }
            }
        }
    }
    
    func setupRightBarButtonItem()  {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(setupAddSongVC))
    }
    
    @objc func setupAddSongVC()  {
        let addSongVC = AddSongViewController()
        addSongVC.navigationItem.title = "Add Song"
        addSongVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissAddSong))

        let navController = UINavigationController(rootViewController: addSongVC)
        navController.navigationBar.prefersLargeTitles = true
        let navAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 28)!,
            NSAttributedString.Key.kern: -0.6
        ]
        
        navController.navigationBar.largeTitleTextAttributes = navAttributes

        self.present(navController, animated: true)
    }
    
    @objc func dismissAddSong() {
        self.dismiss(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! EpisodeInfoCell
            cell.episodeInfo = episode
            return cell
        }   else    {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: songsCellId, for: indexPath) as! SongListCell
            cell.songCellDelegate = self
            cell.songsArray = songs
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0  {
            return CGSize(width: view.frame.width, height: 68)
        }   else    {
            if songs.count > 0 {
                return CGSize(width: view.frame.width, height: CGFloat(songs.count * heightOfSongs) + 36)
            }   else    {
                return CGSize(width: view.frame.width, height: 136)
            }
        }
    }
    
    func didSelectSongDetail(for song: Song)  {
        let songDetailController = SongDetailPopupController()
        songDetailController.song = song
        songDetailController.delegate = self
        songDetailController.navigationItem.title = song.title
        self.navigationController?.present(songDetailController, animated: true, completion: nil)
    }
    func refreshDetailViewScene() {
        if (episode != nil) {
            fetchEpisode()
        }
    }
}
