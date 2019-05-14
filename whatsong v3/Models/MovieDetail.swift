//
//  MovieDetail.swift
//  whatsong v3
//
//  Created by Tom Andrew on 7/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct MovieData: Decodable  {
    let data: MovieDetails
}

struct MovieDetails: Decodable {
    let movie: MovieInfo
    let poster: String?
    let banner: String?
    let CompleteListOfSongs: [Song]
    let albums: [Album]
}

struct MovieInfo: Decodable {
    let _id: Int
    let title: String
    let song_count: Int
    let composer: String?
    let music_supervisor: String?
}

struct Song: Decodable  {
    let _id: Int
    let title: String
    let artist: Artist
    let time_play: Int?
    let scene_description: String?
    let spotifyImg300: String?
    let preview_url: String?
    let spotifyPreviewUrl: String?
    
}

struct Artist: Decodable    {
    let _id: Int
    let name: String
}

struct Album: Decodable {
    let album: AlbumInfo
    let songs: [Song]
}

struct AlbumInfo: Decodable   {
    let _id: Int
    let title: String?
    let thumbnail: String?
    let itunes_url: String?
    let time_released: String?
    let trackCount: String?
    let length: Int?
    
}

//struct AlbumSongs: Decodable    {
//    let _id: Int?
//    let played_time: Int?
//    let title: String?
//    let artist: Artist
//    let preview_url: String?
//    let itunes_url: String?
//    let track_number: Int?
//}
