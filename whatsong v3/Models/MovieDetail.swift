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
    let song_count: Int?
    let composer: String?
    let music_supervisor: String?
    let time_released: String?
    let banner: String?
}

struct Song: Decodable  {
    let _id: Int
    let title: String
    let artist: Artist
    let time_play: Int?
    let scene_description: String?
    let spotifyImg300: String?
    let spotifyImg640: String?
    let preview_url: String?
    let spotifyPreviewUrl: String?
    let track_number: Int?
    let spotify_uri: String?
    let youtube_id: String?
    var is_favorited: Bool?
    
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
