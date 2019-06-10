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
    let headerId = "headerCellId"
    var showDays: [LatestShowsByDay]? = []
    var headerShows = [TvShowInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(ShowsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ShowsHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
        self.extendedLayoutIncludesOpaqueBars = true
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchShowsBySchedule { (showDays, error) in
            if let error = error    {
                print("failed to fetch shows", error)
                return
            }
            self.showDays = showDays?.data
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchFeaturedShows { (shows, error) in
            if let error = error    {
                print("failed to fetch featured shows", error)
                return
            }
            self.headerShows = shows?.data ?? []
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main)  {
            print("completed your dispatch")
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func handleRefresh()    {
        fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! ShowsHeader
        header.showsHeaderHorizontalController.headerShows = self.headerShows
        header.showsHeaderHorizontalController.didSelectHandler = { [weak self] show in
            let controller = TvShowDetailsController()
            controller.showId = show._id
            controller.navigationItem.title = show.title
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        header.showsHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 260)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let days = showDays else { return 0 }
        showDays = days.filter({ !$0.tv_show_details!.isEmpty })
        return showDays!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ShowsGroupCell
        cell.dayData = showDays?[indexPath.row]
        let date = cell.dayData?.released_date.toDate(stringFormat: "dd-MM-yyyy")
        cell.dateLabel.text = date?.toString(dateFormat: "MMM dd, yyyy")
        cell.dayLabel.text = date?.toString(dateFormat: "EEEE")
        cell.horizontalController.tvShows = []
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
