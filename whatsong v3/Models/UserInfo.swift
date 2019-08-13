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

struct SpotifyUserData: Decodable  {
    var id: String!
    var type: String!
    var uri: String!
    var href: String!
    var email: String!
    var display_name: String!
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case uri = "uri"
        case href = "href"
        case email = "email"
        case display_name = "display_name"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        if let id = try container.decodeIfPresent(String.self, forKey: .id) {
            self.id = id
        } else {
            self.id = ""
        }
        
        if let type = try container.decodeIfPresent(String.self, forKey: .type) {
            self.type = type
        } else {
            self.type = ""
        }
        
        if let uri = try container.decodeIfPresent(String.self, forKey: .uri) {
            self.uri = uri
        } else {
            self.uri = ""
        }
        
        if let href = try container.decodeIfPresent(String.self, forKey: .href) {
            self.href = href
        } else {
            self.href = ""
        }
        
        if let email = try container.decodeIfPresent(String.self, forKey: .email) {
            self.email = email
        } else {
            self.email = ""
        }
        if let display_name = try container.decodeIfPresent(String.self, forKey: .display_name) {
            self.display_name = display_name
        } else {
            self.display_name = ""
        }
    }
    //    var successs: Bool
}
