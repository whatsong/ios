//
//  FullUserInfo.swift
//  whatsong v3
//
//  Created by Andrii Shchudlo on 23/05/2019.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

struct FullUserData: Decodable  {
    var data: FullUserInfo
//    var successs: Bool
}

struct FullUserInfo: Decodable {
    var _id: Int?
    var facebook_id: String?
    var username: String?
    var first_name: String?
    var last_name: String?
    var email: String?
    var spotify_user_key: String?
    var rdio_user_key: String?
    var time_last_login: String?
    var photo: String?
    var rdio_location: Int?
    var is_blocked: Int?
    var country: String?
    var restore_code: Int?
    var sex: Int?
    var added_scenes_count: Int?
    var added_songs_count: Int?
    var count_thanks_scene: Int?
    var count_thanks: Int?
    var votes_count: Int?
    var scores: Int?
    var favorite_movie: String?
    var favorited_tv_shows_count: Int?
    var favorited_movies_count: Int?
    var favorited_songs_count: Int?
    var favorite_artist: String?
    var max_user_connections: Int?
    var max_connections: Int?
    var max_updates: Int?
    var role: String?
    var created_at: String?
}
