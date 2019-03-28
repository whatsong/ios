//
//  Movies.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesController: BaseCvController, UICollectionViewDelegateFlowLayout    {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(MoviesGroupCell.self, forCellWithReuseIdentifier: cellId)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        fetchData()
    }
    
    //var latestMovies: LatestMovies?
    
    var movieSections = [LatestMovies]()

    fileprivate func fetchData()    {
        
        var section1: LatestMovies?
        var section2: LatestMovies?
        
        //Dispatch Group helps sync our data requests together.
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchLatestMovies { (movieSectionData, err) in
            if let err =  err   {
                print("Failed to fetch latest movies:", err)
                return
            }
            dispatchGroup.leave()
            section1 = movieSectionData
        }

        dispatchGroup.enter()
        Service.shared.fetchRecentlyAdded { (movieSectionData, err) in
            if let err =  err   {
                print("Failed to fetch recently added movies:", err)
                return
            }
            dispatchGroup.leave()
            section2 = movieSectionData
        }
        dispatchGroup.notify(queue: .main) {
            print("completed your dispatch")
            if let section = section1 {
                self.movieSections.append(section)
            }
            if let section = section2 {
                self.movieSections.append(section)
            }
            self.collectionView.reloadData()
        }
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesGroupCell
        let movieSection = movieSections[indexPath.item]
        
        cell.horizontalController.latestMoviesArray = movieSection
        if indexPath.item == 0 {
            cell.sectionLabel.text = "Latest Releases"
        } else  {
            cell.sectionLabel.text = "Recently Added"
        }
        
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] movie in
            let controller = MovieDetailController()
            controller.movieId = movie._id
            controller.navigationItem.title = movie.title

            self?.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}
