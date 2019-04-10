//
//  MovieDetailController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 7/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MovieDetailController: BaseCvController, UICollectionViewDelegateFlowLayout   {
    
    let songListCellId = "songListCellId"
    
    var songs: [Song] = []
    
    let numberOfSongs = 5
    let heightOfSongs = 100
    
    var movieId: Int!    {
        didSet  {
            let urlString = "https://www.what-song.com/api/movie-info?movieID=\(movieId ?? 0)"
            Service.shared.fetchMovieDetail(urlString: urlString) { (data, err) in
                
                if let err = err {
                    print(err)
                } else  {
                
                    guard let songs = data?.data.CompleteListOfSongs else { return }
                    self.songs = songs
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView.backgroundColor = .white
        //collectionView.register(MovieDetailCell.self, forCellWithReuseIdentifier: movieDetailCellId)
        collectionView.register(SongListCell.self, forCellWithReuseIdentifier: songListCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: songListCellId, for: indexPath) as! SongListCell
        cell.songsArray = songs
        cell.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: view.frame.width, height: CGFloat(songs.count * heightOfSongs) + 150)
    }
    
    
}
