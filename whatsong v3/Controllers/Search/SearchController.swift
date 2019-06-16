//
//  SearchController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage

class SearchController: BaseCvController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate  {
    
    let cellId = "cellId"
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate let enterSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter a search term above"
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
        view.addSubview(enterSearchLabel)
        enterSearchLabel.fillSuperview()
        
        setupSearchBar()
    }
    
    fileprivate var movies = [Title?]()
    fileprivate func setupSearchBar()    {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        // invalidates timer from firing off search request aggresively. So now will only perform fetchTitles request after 0.5seconds instead of after every letter typed.
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.startActivityIndicator()
            Service.shared.fetchTitles(searchTerm: searchText) { (titleArray, success) in
                if success {
                    self.movies = titleArray
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.stopActivityIndicator()
                    }
                } else {
                    //show error
                }
            }
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let movieResult = movies[indexPath.item]
        cell.titleLabel.attributedText = NSAttributedString(string: movieResult?.title ?? "", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        cell.yearLabel.text = "2019"//movieResult?.year
//        cell.yearLabel.attributedText = NSAttributedString(string: movieResult?.year ?? "", attributes: [
//            NSAttributedString.Key.kern: -0.6
//            ])
        let urlPrefix = "https://www.what-song.com"
        let urlSuffix = movieResult?.poster ?? ""
        let url = URL(string: urlPrefix + urlSuffix)
        print(url)
        cell.posterImageView.sd_setImage(with: url)
        cell.posterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchLabel.isHidden = movies.count != 0
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieShow = movies[indexPath.row]
        let movieShowId = movies[indexPath.item]?.id
        if movieShow?.groupName == "Movies" {
            let movieController = MovieDetailController(movieId: movieShowId!)
            movieController.movieId = movieShowId
            movieController.navigationItem.title = movieShow!.title
            navigationController?.pushViewController(movieController, animated: true)
        } else if movieShow?.groupName == "Television" {
            let tvShowViewController = TvShowDetailsController()
            tvShowViewController.showId = movieShowId!
            tvShowViewController.navigationItem.title = movieShow!.title
            navigationController?.pushViewController(tvShowViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
