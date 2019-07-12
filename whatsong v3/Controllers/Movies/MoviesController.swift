//
//  MoviesController1.swift
//  whatsong v3
//
//  Created by Tom Andrew on 10/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesController: ShowsController   {
    
    var movieDays: [MoviesByScheduleByDay]? = []
    var headerMovies = [MovieInfo]()
    var moviesCellId = "moviesCellId"
    var moviesHeaderId = "moviesHeaderId"
    
    let sectionHeadings = ["This Week", "Last Week", "Two Weeks Ago", "Three Weeks Ago", "Four Weeks Ago", "Five Weeks Ago", "Six Weeks Ago"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.register(MoviesGroupCell.self, forCellWithReuseIdentifier: moviesCellId)
        collectionView.register(MoviesHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: moviesHeaderId)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControl
        self.extendedLayoutIncludesOpaqueBars = true
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        DispatchQueue.main.async {
            self.startActivityIndicator(center: CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY))
        }
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Service.shared.fetchMoviesBySchedule { (movieDays, err) in
            if let err = err    {
                print("Failed to fetch movies", err)
                DispatchQueue.main.async {
                    self.showAlert(bgColor: UIColor.brandWarning(), text: "Failed to fetch movies, refreshing feed.")
                }
                self.fetchData()
            }
            self.movieDays = movieDays?.data
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchFeaturedMovies { (movies, err) in
            if let err = err    {
                print("Failed to fetch featured movies", err)
                DispatchQueue.main.async {
                    self.showAlert(bgColor: UIColor.brandWarning(), text: "Failed to fetch movies, refreshing feed.")
                }
                self.fetchData()
            }
            self.headerMovies = movies?.data ?? []
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            print("complete movies dispatch")
            self.collectionView.reloadData()
            self.stopActivityIndicator()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: moviesHeaderId, for: indexPath) as! MoviesHeader
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let days = movieDays else { return 0 }
        movieDays = days.filter({ !$0.movie_details!.isEmpty })
        return movieDays!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moviesCellId, for: indexPath) as! MoviesGroupCell
        cell.dayData = movieDays?[indexPath.row]
        let date = cell.dayData?.weekStart.toDate(stringFormat: "dd-MM-yyyy")
        cell.dateLabel.text = date?.toString(dateFormat: "MMM dd, yyyy")
        
        cell.sectionLabel.text = sectionHeadings[indexPath.item]
        
        cell.horizontalController.latestMoviesArray = []
        cell.horizontalController.latestMoviesArray = movieDays?[indexPath.row].movie_details
        cell.horizontalController.didSelectHandler = { [weak self]
            movie in
            let controller = MovieDetailController(movieId: movie._id)
            controller.movieId = movie._id
            controller.navigationItem.title = movie.title
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        return cell
    }
    
    @objc func handleSlideInMenu()    {
    }
}
