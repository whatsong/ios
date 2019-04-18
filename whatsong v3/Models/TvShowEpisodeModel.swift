//
//  TvShowEpisodeModel.swift
//  whatsong v3
//
//  Created by Tom Andrew on 17/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct TvShowEpisodeModel: Decodable    {
    var data: TvShowEpisodeData?
    var success: Bool
}

struct TvShowEpisodeData: Decodable {
    var tv_show: TvShowInfo
    //var episode: TvShowEpisodeInfo
    var CompleteListOfSongs: [Song]
}



