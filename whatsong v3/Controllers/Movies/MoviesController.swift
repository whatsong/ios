//
//  Movies.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.


import UIKit

class MoviesController: BaseCvController, UICollectionViewDelegateFlowLayout    {
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = UIColor.brandLightGrey()
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

        collectionView.register(MoviesGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MoviesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
        self.extendedLayoutIncludesOpaqueBars = true
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    var movieSections = [LatestMovies]()
    var headerMovies = [MovieInfo]()

    fileprivate func fetchData()    {
        var section1: LatestMovies?
        var section2: LatestMovies?
        
        //Dispatch Group helps sync our data requests together.
        let dispatchGroup = DispatchGroup()
        
        //startActivityIndicator()
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
        
        dispatchGroup.enter()
        Service.shared.fetchFeaturedMovies { (movies, err) in
            if let err = err    {
                print("Failed to fetch featured movies:", err)
            }
            dispatchGroup.leave()
            self.headerMovies = movies?.data ?? []
        }
        
        // completion
        dispatchGroup.notify(queue: .main) {
            print("completed your dispatch")
            self.activityIndicatorView.stopAnimating()
            if let section = section1 {
                self.movieSections.append(section)
            }
            if let section = section2 {
                self.movieSections.append(section)
            }
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
            //self.stopActivityIndicator()
        }
    }
    
    @objc func handleRefresh()    {
        fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MoviesHeader
        header.moviesHeaderHorizontalController.headerMovies = self.headerMovies
        header.moviesHeaderHorizontalController.didSelectHandler = { [weak self] movie in
            let controller = MovieDetailController(movieId: movie._id)
            controller.movieId = movie._id
            controller.navigationItem.title = movie.title
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        header.moviesHeaderHorizontalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 260)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieSections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoviesGroupCell
        let movieSection = movieSections[indexPath.item].data
        
        cell.horizontalController.latestMoviesArray = movieSection
        if indexPath.item == 0 {
            cell.sectionLabel.text = "Latest Releases"
        } else  {
            cell.sectionLabel.text = "Popular this Year"
        }
        
        cell.horizontalController.collectionView.reloadData()
        cell.horizontalController.didSelectHandler = { [weak self] movie in
            let controller = MovieDetailController(movieId: movie._id)
            controller.movieId = movie._id
            controller.navigationItem.title = movie.title
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
        
    }
}
