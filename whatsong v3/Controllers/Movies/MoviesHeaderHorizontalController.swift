//
//  MoviesHeaderHorizontalController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 26/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    var headerMovies = [MovieInfo]()
    
    var didSelectHandler: ((MovieInfo) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MoviesHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesHeaderCell
        let movie = headerMovies[indexPath.item]
        cell.titleLabel.text = movie.title
        cell.songCountLabel.text = "\(movie.song_count ?? 0) songs"
        let urlPrefix = "https://www.what-song.com"
        let urlSuffix = movie.banner ?? ""
        let url = URL(string: urlPrefix + urlSuffix)
        cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageView.sd_imageIndicator?.startAnimatingIndicator()
        cell.imageView.sd_setImage(with: url, completed: nil)


        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = headerMovies[indexPath.item]
        didSelectHandler?(movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.85, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    }
}
