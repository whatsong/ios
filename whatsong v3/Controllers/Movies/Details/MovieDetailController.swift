//
//  MovieDetailController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 7/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MovieDetailController: BaseCvController, UICollectionViewDelegateFlowLayout, AlbumCellDelegate   {
    
    let infoCellId = "infoCellId"
    let albumsListCellId = "albumsCellId"
    let songListCellId = "songListCellId"
    
    var movieInfo: MovieInfo?
    var songs: [Song] = []
    var albums: [Album] = []
    
    let heightOfSongs = 100
    
    // dependency injection constructor
    init(movieId: Int?) {
        self.movieId = movieId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var movieId: Int!    {
        didSet  {
            let urlString = "https://www.what-song.com/api/movie-info?movieID=\(movieId ?? 0)"
            Service.shared.fetchMovieDetail(urlString: urlString) { (data, err) in
                
                if let err = err {
                    print(err)
                } else  {
                
                    guard let movieData = data?.data else { return }
                    //guard let songs = data?.data.CompleteListOfSongs else { return }
                    
                    self.movieInfo = movieData.movie
                    self.albums = movieData.albums
                    self.songs = movieData.CompleteListOfSongs
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieInfoCell.self, forCellWithReuseIdentifier: infoCellId)
        collectionView.register(AlbumsList.self, forCellWithReuseIdentifier: albumsListCellId)
        collectionView.register(SongListCell.self, forCellWithReuseIdentifier: songListCellId)
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 50, right: 0)

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if albums.count != 0 {
        return 3
        }   else    {
            return 2
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! MovieInfoCell
            cell.movieInfo = movieInfo
            cell.collectionView.reloadData()
            return cell
        } else if indexPath.item == 1 && albums.count != 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumsListCellId, for: indexPath) as! AlbumsList
            cell.albumsArray = albums
            cell.albumCellDelegate = self
            cell.collectionView.reloadData()
        return cell
        } else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: songListCellId, for: indexPath) as! SongListCell
            cell.songsArray = songs
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 68)
        } else if indexPath.item == 1 && albums.count != 0 {
            return CGSize(width: view.frame.width, height: CGFloat(albums.count * 100) + 40)
        } else  {
            return CGSize(width: view.frame.width, height: CGFloat(songs.count * heightOfSongs) + 36)
        }
    }
    
    func didSelectAlbum(for album: Album)  {
        let albumSongsController = AlbumController()
        albumSongsController.albumSongs = album.songs
        albumSongsController.navigationItem.title = "\(album.album.title ?? "Title Unknown")"
        navigationController?.pushViewController(albumSongsController, animated: true)
    }
}
