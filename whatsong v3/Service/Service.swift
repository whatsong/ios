//
//  Service.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

class Service   {
    
    static let shared = Service()   //singleton
    
    func fetchTitles()  {
        

    }
    
    func fetchLatestMovies(completion: @escaping (LatestMovies?, Error?) -> ()) {
        let urlString = "https://www.what-song.com/api/recent-movies"
        fetchMovieSections(urlString: urlString, completion: completion)
    }
    
    func fetchRecentlyAdded(completion: @escaping (LatestMovies?, Error?) -> ()) {
        let urlString = "https://www.what-song.com/api/recently/added/movie"
        fetchMovieSections(urlString: urlString, completion: completion)
    }
    
    func fetchMovieSections(urlString: String, completion: @escaping (LatestMovies?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err    {
                completion(nil, err)
                return
            }
            do  {
                let movieSectionData = try JSONDecoder().decode(LatestMovies.self, from: data!)
                completion(movieSectionData, nil)
            } catch    {
                completion(nil, error)
            }
            }.resume()
    }
    
    
    func fetchMovieDetail(urlString: String, completion: @escaping (MovieData?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err    {
                completion(nil, err)
                return
            }
            do  {
                let movieData = try JSONDecoder().decode(MovieData.self, from: data!)
                completion(movieData, nil)
            } catch    {
                completion(nil, error)
            }
            }.resume()
    }
}
