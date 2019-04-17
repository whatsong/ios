//
//  Service.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

class Service   {
    
    static let shared = Service() //singleton
    
    func fetchTitles(searchTerm: String, completion: @escaping (_ resultArray: Array<Title>, _ success: Bool) -> Void)  {
        var titlesArray = Array<Title>()
        
        let urlString = "https://www.what-song.com/api/search?limit=10&type=movie&field=\(searchTerm)"
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
                for group in results.searchData {
                    
                    if let group = group {
                        for movie in group.groupResults {
                            if let movie = movie {
                                titlesArray.append(movie)
                            }
                        }
                    }
                }
                completion(titlesArray, true)
                
            }   catch   {
                completion(titlesArray, false)
            }
            }.resume()
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
    
    func fetchLatestShows(completion: @escaping ([LatestShowsByDay]?, Error?) -> ()) {
        
        let urlString = "https://www.what-song.com/api/air-episodes"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //if error
            if let error = error    {
                completion(nil, error)
                return
            }
            //success
            guard let data = data else { return }
            
            do {
                let showDays = try JSONDecoder().decode(LatestShowsData.self, from: data).data
                completion(showDays, nil)
            }   catch let jsonErr {
                completion(nil, jsonErr)
                print("Error serializing JSON", jsonErr)
            }
            }.resume()
    }
    
    func fetchTvShowDetail(urlString: String, completion: @escaping (TvShowStruct?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err    {
                completion(nil, err)
                return
            }
            do  {
                let tvShowData = try JSONDecoder().decode(TvShowStruct.self, from: data!)
                completion(tvShowData, nil)
            } catch    {
                completion(nil, error)
            }
            }.resume()
    }
    
    func fetchTvShowSeason(urlString: String, completion: @escaping (TvShowSeasonStruct?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err    {
                completion(nil, err)
                return
            }
            do  {
                let tvShowSeasonData = try JSONDecoder().decode(TvShowSeasonStruct.self, from: data!)
                completion(tvShowSeasonData, nil)
            } catch    {
                completion(nil, error)
            }
            }.resume()
    }
    
    func fetchTvShowEpisode(urlString: String, completion: @escaping (TvShowEpisodeModel?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err    {
                completion(nil, err)
                return
            }
            do  {
                let tvShowEpisodeData = try JSONDecoder().decode(TvShowEpisodeModel.self, from: data!)
                completion(tvShowEpisodeData, nil)
            } catch    {
                completion(nil, error)
            }
            }.resume()
    }
}
