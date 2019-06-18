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
                
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions.insert(.withFractionalSeconds)
                if let date = formatter.date(from: userInfo.created_at ?? "") {
                    let dateString = date.stringDate
                    subtitleArray.append(dateString)
                }
            }
        }
        collectionView.reloadData()
    }
}
