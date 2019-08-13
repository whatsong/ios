//
//  SpotifyUserPlaylist.swift
//  whatsong v3
//
//  Created by Developer iOS on 07/08/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit


struct SpotifyUserPlaylist: Decodable {
    let items: [itemPlaylistDetail]
}
struct itemPlaylistDetail: Decodable  {
    let id: String
    let name: String
}
