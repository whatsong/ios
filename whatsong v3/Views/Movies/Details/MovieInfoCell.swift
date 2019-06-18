//
//  MovieInfoCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 8/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit


class MovieInfoCell: ShowInfoCell   {
    
    var movieInfo: MovieInfo? {
        didSet {
            fillHeaderArrayAndSubtitleArray()
        }
    }
    
    override func fillHeaderArrayAndSubtitleArray(){
        headerArray = []
        subtitleArray = []
        if let movieInfo = movieInfo {
            if movieInfo.time_released != nil {
                headerArray.append("Release Date")
                
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions.insert(.withFractionalSeconds)
                if let date = formatter.date(from: movieInfo.time_released!) {
                    let dateString = date.stringDate
                    print(dateString) // October 2014
                    subtitleArray.append(dateString)

                }
            }
            
            if movieInfo.music_supervisor != nil {
                headerArray.append("Music Supervisor")
                subtitleArray.append(movieInfo.music_supervisor!)
            }
            if movieInfo.song_count != nil {
                headerArray.append("# of Songs")
                subtitleArray.append("\(movieInfo.song_count ?? 0)")
            }
            if movieInfo.composer != nil {
                headerArray.append("Composer")
                subtitleArray.append(movieInfo.composer!)
            }
        }
        collectionView.reloadData()
    }
}
