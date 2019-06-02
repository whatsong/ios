//
//  ProfileUserCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 27/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class UserInfoCell: ShowInfoCell   {
    
    var userInfo: UserInfo? {
        didSet {
            fillHeaderArrayAndSubtitleArray()
        }
    }
    
    override func fillHeaderArrayAndSubtitleArray(){
        headerArray = []
        subtitleArray = []
        if let userInfo = userInfo {
            if userInfo.username != nil {
                headerArray.append("Username")
                subtitleArray.append(userInfo.username ?? "")
            }
            if userInfo.added_songs_count != nil {
                headerArray.append("Points")
                subtitleArray.append("\(userInfo.scores ?? 0)")
            }
            if userInfo.added_scenes_count != nil {
                headerArray.append("Role")
                subtitleArray.append(userInfo.role ?? "")
            }
            if userInfo.added_scenes_count != nil {
                headerArray.append("Joined")
                subtitleArray.append(userInfo.created_at ?? "")
            }
        }
        collectionView.reloadData()
    }
}
