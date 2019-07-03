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
    
    
    var observer:Any?
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
        NotificationCenter.default.post(name: .wsNotificationPlayerStartBuffer, object: nil)
        preriodicTimeObsever()
    }
    
    func preriodicTimeObsever(){
        
        if let observer = self.observer{
            //removing time obse
            player.removeTimeObserver(observer)
            self.observer = nil
        }
        
        let intervel : CMTime = CMTimeMake(value: 1, timescale: 10)
        observer = player.addPeriodicTimeObserver(forInterval: intervel, queue: DispatchQueue.main) { [weak self] time in
            
            guard let `self` = self else { return }
            
            //this is the slider value update if you are using UISlider.
            if self.player.currentItem?.status == .readyToPlay {
                NotificationCenter.default.post(name: .wsNotificationPlayerFinishBuffer, object: nil)
                self.player.removeTimeObserver(self.observer)
                self.observer = nil
            } else {
                NotificationCenter.default.post(name: .wsNotificationPlayerStartBuffer, object: nil)
            }
        }
    }
    
    func nilPlayer() {
        player.replaceCurrentItem(with: nil)
        if let observer = self.observer{
            
            player.removeTimeObserver(observer)
            self.observer = nil
        }
    }

}
