//
//  TvShowDetail.swift
//  whatsong v3
//
//  Created by Tom Andrew on 9/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct TvShowStruct: Decodable  {
    var data: TvShowData?
    var success: Bool
}

struct TvShowData: Decodable    {
    var tv_show: TvShowInfo?
}

struct TvShowInfo: Decodable   {
    var _id: Int
    var title: String
    var year: Int?
    var poster: String?
    var banner: String?
    var music_supervisor: String?
    var composer: String?
    var network: String?
    var song_count: Int?
    var imdb_id: Int?
    var moviedb_id: Int?
//    var theme_song: TvThemeSong?
//    var last_episodes: [TvLastEpisodes]?
//    var seasons: [Seasons]?
//    var discussions: [TvDiscussions]?
//    var Contributors: [TvContributors]?
//    var PopularSongs: [TvPopularSongs]?
    
}

struct TvThemeSong: Decodable   {
    
}

struct TvLastEpisodes: Decodable    {
    
}

struct Seasons: Decodable   {
    
}

struct TvDiscussions: Decodable {
    
}

struct TvContributors: Decodable  {
    
}

struct TvPopularSongs: Decodable    {
    
}
