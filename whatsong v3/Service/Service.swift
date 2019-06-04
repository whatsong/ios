//
//  Service.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

class Service   {
    
    static let shared = Service()
    
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
        let urlString = "https://www.what-song.com/api/popular-movies"
        fetchMovieSections(urlString: urlString, completion: completion)
    }
    
    func fetchMovieSections(urlString: String, completion: @escaping (LatestMovies?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func getCurrentUserInfo(completion: @escaping(UserData?, _ success: Bool) -> ()) {
        if let token = DAKeychain.shared["accessToken"] {
            var request = URLRequest(url:URL(string:"https://www.what-song.com/api/me")!)
            request.addValue("\(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            //http get
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard(error == nil) else {
                    completion(nil, false)
                    return
                }
                do {
                    let parseResult = try JSONDecoder().decode(UserData.self, from: data!)
                    completion(parseResult, true)
                } catch {
                    completion(nil, false)
                }
                }.resume()
        } else {
            completion(nil, false)
        }
    }
    
    func fetchCurrentUserSongs(urlString: String, completion: @escaping (SongLibrary?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchMovieDetail(urlString: String, completion: @escaping (MovieData?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchLatestShows(completion: @escaping (LatestShowsData?, Error?) -> ()) {
        let urlString = "https://www.what-song.com/api/air-episodes"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTvShowDetail(urlString: String, completion: @escaping (TvShowStruct?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTvShowSeason(urlString: String, completion: @escaping (TvShowSeasonStruct?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTvShowEpisode(urlString: String, completion: @escaping (TvShowEpisodeModel?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchFeaturedMovies(completion: @escaping (FeaturedMoviesData?, Error?) -> Void)  {
        let urlString = "https://www.what-song.com/api/movies/featured"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchFeaturedShows(completion: @escaping (FeaturedShowsData?, Error?) -> Void)  {
        let urlString = "https://www.what-song.com/api/tv_shows/featured"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ())   {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err    {
                completion(nil, err)
                return
            }
            do  {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                completion(objects, nil)
            } catch    {
                completion(nil, error)
            }
            }.resume()
    }
}
