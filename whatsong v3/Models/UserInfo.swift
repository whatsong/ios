//
//  UserInfo.swift
//  whatsong v3
//
//  Created by Tom Andrew on 21/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct UserData: Decodable  {
    var data: UserInfo
//    var successs: Bool
}

struct UserInfo: Decodable  {
    var _id: Int?
    var username: String?
    var first_name: String?
    var last_name: String?
    var photo: String?
    var added_scenes_count: Int?
    var added_songs_count: Int?
    var scores: Int?
    var role: String?
    var created_at: String?
}

