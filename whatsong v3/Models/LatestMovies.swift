//
//  LatestMovies.swift
//  whatsong v3
//
//  Created by Tom Andrew on 6/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct LatestMovies: Decodable  {
    let data: [LatestMovie]
}

struct LatestMovie: Decodable  {
    let _id: Int
    let title: String
    let year: String?
    let poster: String?
    var song_count: Int?
    
}

struct SongFavResponce: Decodable {
    let success: Bool
}
