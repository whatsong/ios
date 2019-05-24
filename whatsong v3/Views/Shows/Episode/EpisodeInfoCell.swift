//
//  Episode.swift
//  whatsong v3
//
//  Created by Tom Andrew on 17/4/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class EpisodeInfoCell: ShowInfoCell {
    
    var episodeInfo: TvShowEpisodes? {
        didSet  {
            fillHeaderArrayAndSubtitleArray()

        }
    }
    
    override func fillHeaderArrayAndSubtitleArray(){
        headerArray = []
        subtitleArray = []
        if let episodeInfo = episodeInfo {
        
            headerArray.append("Air Date")
            
            let timeStamp = Double(episodeInfo.date_released) / 1000
            let date = Date(timeIntervalSince1970: timeStamp)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let strDate = dateFormatter.string(from: date)
            
            subtitleArray.append(strDate)
        
            if episodeInfo.songs_count != nil {
                headerArray.append("# of Songs")
                
                subtitleArray.append("\(episodeInfo.songs_count ?? 0)")
            }
        }
        collectionView.reloadData()
    }
}
