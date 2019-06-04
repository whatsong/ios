//
//  FeaturedTitles.swift
//  whatsong v3
//
//  Created by Tom Andrew on 4/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct FeaturedMoviesData: Decodable    {
    let data: [MovieInfo]
}

struct FeaturedShowsData: Decodable {
    let data: [TvShowInfo]
}
