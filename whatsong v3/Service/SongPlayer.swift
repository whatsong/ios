//
//  SongPlayer.swift
//  whatsong v3
//
//  Created by Andrii Shchudlo on 26/05/2019.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import AVKit

class SongPlayer {
    
    static let shared = SongPlayer()
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    var currentlyPlayingUrl: String?
    var previewUrl: String?
    
    func doesPreviewExist(spotifyPreviewUrl: String?, iTunesPreviewUrl: String?) -> Bool    {
        if spotifyPreviewUrl != nil && spotifyPreviewUrl != "0" {
            print("Spotify preview exists.")
            previewUrl = spotifyPreviewUrl
            return true
        } else if iTunesPreviewUrl != "" && iTunesPreviewUrl != nil   {
            print("iTunes preview exists.")
            previewUrl = iTunesPreviewUrl
            return true
        }   else    {
            print("No audio preview exists.")
            previewUrl = nil
            return false
        }
    }
    
    func playSong()  {
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        currentlyPlayingUrl = previewUrl
    }
    
    func nilPlayer() {
        player.replaceCurrentItem(with: nil)
    }

}
