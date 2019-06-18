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
        
        let urlString = "https://www.what-song.com/api/search?limit=10&type=all&field=\(searchTerm)"
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
                    //for future just delete this "if"
                    if group?.groupName != "Artists" {
                        if let group = group {
                            for movie in group.groupResults {
                                if var movie = movie {
                                    movie.groupName = group.groupName
                                    titlesArray.append(movie)
                                }
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
    
    func signUp(login: String, password: String, mail: String, completion: @escaping (_ result: Bool, _ errorMessage: String?) -> Void) {
        var request = URLRequest(url: URL(string: "https://www.what-song.com/api/sign-up")!)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "username" : login,
            "password" : password,
            "email" : mail]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard(error == nil) else {
                completion(false, error?.localizedDescription)
                return
            }
            if let data = data {
                do {
                    let parseResult = try JSONDecoder().decode(SignUpResponce.self, from: data)
                    if parseResult.success {
                        completion(true, nil)
                    } else {
                        var errorMessage:String?
                        if let error = parseResult.error, let errors = error.errors {
                            if let mail = errors.email {
                                errorMessage = mail.message
                            }
                            if let username = errors.username {
                                errorMessage = username.message
                            }
                        }
                        completion(false, errorMessage)
                    }
                    
                } catch {
                    completion(false, "Something went wrong")
                }
            }
        }.resume()
    }
    
    func addTofavourite(songId: String?, type: String, like: Bool, completion: @escaping (_ result: Bool) -> Void) {
        if let songId = songId {
            var request = URLRequest(url:URL(string:"https://www.what-song.com/api/user-action/favourite")!)
            request.addValue(DAKeychain.shared["accessToken"]!, forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "type" : type,
                "itemID" : Int(songId)!,
                "like" : like]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            URLSession.shared.dataTask(with: request){ data, response, error in
                guard(error == nil) else {
                    completion(false)
                    return
                }
                if let data = data {
                    do {
                        let parseResult = try JSONDecoder().decode(SignUpResponce.self, from: data)
                        print(parseResult)
                        if parseResult.success {
                            completion(true)
                        } else {
                            completion( false)
                        }
                        
                    } catch {
                        completion( false)
                    }
                }
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    completion(true)

                } else {
                    completion(false)
                }
                
                }.resume()
        } else {
            completion(false)
        }
    }
    
    func fetchLatestMovies(completion: @escaping (LatestMovies?, Error?) -> ()) {
        let urlString = "https://www.what-song.com/api/recent-movies"
        fetchMovieSections(urlString: urlString, completion: completion)
    }
    
    func fetchRecentlyAdded(completion: @escaping (LatestMovies?, Error?) -> ()) {
        let urlString = "https://www.what-song.com/api/popular-movies"
        fetchMovieSections(urlString: urlString, completion: completion)
    }
    
    func fetchMoviesBySchedule(completion: @escaping (MoviesByScheduleData?, Error?) -> ()) {
        let urlString = "https://www.what-song.com/api/air-movies"
        fetchGenericJSONData(urlString: urlString, completion: completion)
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
    
    func fetchShowsBySchedule(completion: @escaping (LatestShowsData?, Error?) -> ()) {
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

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
