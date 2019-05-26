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
    
    var playerUrl:String?
    
    func playSong(song: String?)  {
        guard let url = URL(string: song ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        playerUrl = song
    }
    
    func nilPlayer() {
        player.replaceCurrentItem(with: nil)
    }

}
