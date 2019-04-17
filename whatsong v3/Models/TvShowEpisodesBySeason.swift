//
//  TvShowSeason.swift
//  whatsong v3
//
//  Created by Tom Andrew on 17/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct TvShowSeasonStruct: Decodable  {
    var data: TvShowSeasonData?
    var success: Bool
}

struct TvShowSeasonData: Decodable  {
    var episodes: [TvShowEpisodes]
}

struct TvShowEpisodes: Decodable    {
    var _id: Int
    var name: String
    var date_released: Int
    var number: Int
    var songs_count: Int
}
