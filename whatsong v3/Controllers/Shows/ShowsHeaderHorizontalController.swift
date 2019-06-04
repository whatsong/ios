//
//  ShowsHeaderController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ShowsHeaderHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout   {
    
    let cellId = "cellId"
    var headerShows = [TvShowInfo]()
    
    var didSelectHandler: ((TvShowInfo) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ShowsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = headerShows[indexPath.item]
        didSelectHandler?(show)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowsHeaderCell
        let show = headerShows[indexPath.item]
        cell.titleLabel.text = show.title
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.85, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    }
    
}
