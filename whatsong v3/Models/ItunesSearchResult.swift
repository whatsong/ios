//
//  SongItunesResult.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct ItunesSearchResult: Decodable {
    let resultCount: Int
    let results: [ItunesSearchResultSong]
}

struct ItunesSearchResultSong: Decodable {
    var trackName: String?
    var artistName: String?
    var previewUrl: String?
    var collectionName: String?
}
