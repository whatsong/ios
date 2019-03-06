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
    
    func fetchTitles(searchTerm: String, completion:@escaping (_ resultArray: Array<Title>, _ success: Bool) -> Void)  {
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
    
    
    func fetchTitles()  {
        

    }
}
