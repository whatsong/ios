//
//  LatestShows.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct LatestShowsData: Decodable  {
    var data: [LatestShowsByDay]
}

struct LatestShowsByDay: Decodable  {
    var released_date: String
    var tv_show_details: [ShowDetails]?
}

struct ShowDetails: Decodable   {
    var _id: Int
    var name: String
    var poster: String
    var song_count: Int
    var tv_show: TvShow
}

struct TvShow: Decodable    {
    var _id: Int
    var title: String
}

struct MoviesByScheduleData: Decodable  {
    var data: [MoviesByScheduleByDay]
}

struct MoviesByScheduleByDay: Decodable  {
    var weekStart: String
    var weekEnd: String
    var movie_details: [LatestMovie]?
}




