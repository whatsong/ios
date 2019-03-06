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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Service.shared.fetchTitles(searchTerm: searchText) { (titleArray, success) in
            if success {
                self.movies = titleArray
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                //show error
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        let movieResult = movies[indexPath.item]
        cell.titleLabel.text = movieResult?.name
        cell.yearLabel.text = movieResult?.year
        let urlPrefix = "https://www.what-song.com"
        let urlSuffix = movieResult?.poster ?? ""
        let url = URL(string: urlPrefix + urlSuffix)
        print(url)
        cell.posterImageView.sd_setImage(with: url)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
