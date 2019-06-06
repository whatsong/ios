//
//  ShowsHorizontalController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage

class ShowsHorizontalController: UICollectionViewController, UICollectionViewDelegateFlowLayout   {
    
    var tvShows: [ShowDetails]?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        
        collectionView.register(ShowsSingleCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowsSingleCell
        cell.tvShow = tvShows?[indexPath.row]
        let show = tvShows?[indexPath.row]
        cell.titleLabel.text = show?.tv_show.title
        cell.songCountLabel.text = "\(show?.song_count ?? 0) songs"
        let url =  URL(string: show?.poster ?? "")
        cell.posterImageView.sd_setImage(with: url)
        cell.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShows!.count
    }
    
    var didSelectHandler: ((ShowDetails) -> ())?

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let show = tvShows?[indexPath.item] {
            didSelectHandler?(show)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 234)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
