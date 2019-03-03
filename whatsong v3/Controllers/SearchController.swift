//
//  SearchController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchTitles()
    }
    
    fileprivate var movies = [Title?]()
    
    func fetchTitles()  {
        let urlString = "https://www.what-song.com/api/search?limit=10&type=movie&field=america"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // if error occurs
            if let err = err    {
                print("Failed to fetch titles", err)
                return
            }
            
            // if success
            guard let data = data else { return }
            
            do {
                let results =  try JSONDecoder().decode(SearchData.self, from: data)
                print(results)
                for group in results.searchData {
                    
                    if let group = group {
                        for movie in group.groupResults {
                            self.movies.append(movie)
            
                        }
                    }
               }
                print(self.movies)
                
            }   catch   {
                print("Failed to decode JSON:", error)
            }
        }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.titleLabel.text = "American Psycho"
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(movies)
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
}
