//
//  TvShow.swift
//  whatsong v3
//
//  Created by Tom Andrew on 9/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class TvShowDetailsController: BaseCvController, UICollectionViewDelegateFlowLayout    {
    
    let infoCellId = "cellId"
    
    var tvShowInfo: TvShowInfo?
    var popularSongs: [TvPopularSongs]? = []
    
    var showId: Int!    {
        didSet {
            let urlString = "https://www.what-song.com/api/tv-info?tvshowID=\(showId ?? 0)"
            Service.shared.fetchTvShowDetail(urlString: urlString) { (data, err) in
                
                if let err = err {
                    print(err)
                } else  {
                    
                    guard let tvInfo = data?.data?.tv_show else { return }
                    print(tvInfo)
                    self.tvShowInfo = tvInfo
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
            print("this is my ID", showId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ShowInfoCell.self, forCellWithReuseIdentifier: infoCellId)
    
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! ShowInfoCell
        cell.showInfo = tvShowInfo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 68)
    }
}
