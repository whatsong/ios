//
//  ShowsController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 3/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ShowsController: BaseCvController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    var showDays: [LatestShowsByDay]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.register(ShowsGroupCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchData()
        
    }
    
    fileprivate func fetchData() {
    
        Service.shared.fetchLatestShows { (showDays, error) in
            if let error = error    {
                print("failed to fetch shows", error)
                return
            }
            self.showDays = showDays
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let days = showDays else { return 0 }
        return days.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowsGroupCell
        cell.dayData = showDays?[indexPath.row]
        let date = cell.dayData?.released_date.toDate(stringFormat: "dd-MM-yyyy")
        cell.dateLabel.text = date?.toString(dateFormat: "MMM dd, yyyy")
        cell.dayLabel.text = date?.toString(dateFormat: "EEEE")
        
        cell.horizontalController.tvShows = showDays?[indexPath.row].tv_show_details
        cell.horizontalController.didSelectHandler = { [weak self]
            show in
            let controller = TvShowDetailsController()
            controller.showId = show.tv_show._id
            controller.navigationItem.title = show.tv_show.title
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
}
