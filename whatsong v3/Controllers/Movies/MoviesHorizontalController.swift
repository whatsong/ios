//
//  MoviesHorizontalController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SkeletonView

class MoviesHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource  {
    
    
    let cellId = "cellId"
    var latestMoviesArray: LatestMovies?
    
    var didSelectHandler: ((LatestMovie) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MoviesSingleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        
    }
    
    let topBottomSpacing: CGFloat = 12
    let lineSpacing: CGFloat = 12
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestMoviesArray?.data.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesSingleCell
        let movie = latestMoviesArray?.data[indexPath.item]
        cell.titleLabel.text = movie?.title
        cell.yearLabel.text = movie?.year
        cell.songCountLabel.text = "\(movie?.song_count ?? 0) songs"
        let urlPrefix = "https://www.what-song.com"
        let urlSuffix = movie?.poster ?? ""
        let url = URL(string: urlPrefix + urlSuffix)
        cell.imageView.sd_setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: (view.frame.height - topBottomSpacing * 2 - lineSpacing * 2) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: topBottomSpacing, left: 20, bottom: topBottomSpacing, right: 40)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = latestMoviesArray?.data[indexPath.item]  {
            didSelectHandler?(movie)
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellId
    }
}
