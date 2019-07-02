//
//  Search.swift
//  whatsong v3
//
//  Created by Tom Andrew on 19/2/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

struct SearchData: Decodable  {
    let searchData: [Group?]
    let success: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case searchData = "data"
        case success = "success"
    }
}

struct Group: Decodable  {
    let groupName: String?
    let groupResults: [Title?]
    
    private enum CodingKeys: String, CodingKey {
        case groupName = "group"
        case groupResults = "data"
    }
}

struct Title: Decodable {
    let id: Int?
    let name: String?
    let year: Int?
    let poster: String?
    let slug: String?
    let title: String?
    var groupName: String?
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.slug = try values.decode(String.self, forKey: .slug)
        if values.contains(.title) {
            self.title = try values.decodeIfPresent(String.self, forKey: .title)
        } else {
            self.title = nil
        }
        groupName = nil
        
        if values.contains(.year) {
            self.year = try values.decodeIfPresent(Int.self, forKey: .year)
        } else {
            self.year = nil
        }
        
        if values.contains(.poster) {
            self.poster = try values.decodeIfPresent(String.self, forKey: .poster)
        } else {
            self.poster = nil
        }
        
        if values.contains(.name) {
            self.name = try values.decodeIfPresent(String.self, forKey: .name)
        } else {
            self.name = nil
        }
    }
    
    
    private enum CodingKeys: String, CodingKey {

        
        case id = "_id"
        case title = "title"
        case year = "year"
        case poster = "poster"
        case slug = "slug"
        case name = "name"
    }
}


