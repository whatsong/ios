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
    
    private enum CodingKeys: String, CodingKey {
        case searchData = "data"
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
    let name: String?
    let year: String?
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case year = "year"
        case poster = "poster_url"

    }
}
