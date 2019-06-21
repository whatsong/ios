//
//  SongDetailPopup1.swift
//  whatsong v3
//
//  Created by Tom Andrew on 10/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage

class SongDetailPopupController: BaseCvController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "songId"
    var song: Song?
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissFunc), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .clear
        collectionView.register(SongDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.allowsSelection = false
        view.addSubview(dismissButton)
        
        dismissButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        dismissButton.constrainHeight(constant: 50)
        
    }
    
    @objc func dismissFunc()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongDetailCell
        cell.song = song
        cell.youtubeButton.addTarget(self, action: #selector(openWithYoutube(sender:)), for: .touchUpInside)
        cell.spotifyButton.addTarget(self, action: #selector(openWithSpotify(sender:)), for: .touchUpInside)
        cell.setPlayPauseOnAppearing()
        cell.playPauseButton.addTarget(self, action: #selector(handlePlayPause(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func youTubeAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
    }
    
    @objc func handlePlayPause(sender: UIButton) {
        
        if SongPlayer.shared.currentlyPlayingUrl == song?.preview_url || SongPlayer.shared.currentlyPlayingUrl == song?.spotifyPreviewUrl   {
            if SongFloatingPlayer.tabBarContainPlayer() {
                let currentViewPlayer = SongFloatingPlayer.getCurrentPlayerFromTabBar()
                if SongPlayer.shared.player.timeControlStatus == .paused {
                    currentViewPlayer?.playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
                } else  {
                    currentViewPlayer?.playPauseButton.setImage(UIImage(named: "play-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
                }
            }
            
            if SongPlayer.shared.player.timeControlStatus == .paused    {
                print("paused")
                sender.setImage(UIImage(named: "pause-button-large"), for: .normal)
                SongPlayer.shared.player.play()

            } else if SongPlayer.shared.player.timeControlStatus == .playing    {
                print("playing")
                SongPlayer.shared.player.pause()
                sender.setImage(UIImage(named: "play-button-large"), for: .normal)
            }
        }   else if SongPlayer.shared.currentlyPlayingUrl != song?.preview_url {
            sender.setImage(UIImage(named: "pause-button-large"), for: .normal)
            SongPlayer.shared.playSong()
        
            if SongFloatingPlayer.tabBarContainPlayer() {
                let currentViewPlayer = SongFloatingPlayer.getCurrentPlayerFromTabBar()
                currentViewPlayer?.song = song
                currentViewPlayer?.playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
    
            print("playing new song")
        }   else    {
            print("something else")
        }

    }
    
    @objc func openWithYoutube(sender: UIButton)  {
        if let song = song {
            let youtubeId = song.youtube_id
            let appUrl = URL(string: "youtube://\(youtubeId ?? "")")
            let webUrl = URL(string: "https://youtube.com/watch?v=\(youtubeId ?? "")")
            
            let application = UIApplication.shared
            
            if application.canOpenURL(appUrl!)   {
                application.open(appUrl!)
            }   else    {
                application.open(webUrl!)
            }
        }
    }
    
    @objc func openWithSpotify(sender: UIButton)  {
        print("open with spotfiy")
        if let song = song {
            if isSpotifyInstalled() {
                let url = URL(string: song.spotify_uri ?? "")
                UIApplication.shared.open(url!)
            } else {
                var str = song.spotify_uri!
                str = str.replacingOccurrences(of: "spotify:track:", with: "", options: [.anchored], range: nil)
                let fullString = "https://open.spotify.com/track/" + str
                UIApplication.shared.open(URL(string: fullString)!)
            }
        }
    }
    
    func isSpotifyInstalled() -> Bool  {
        return UIApplication.shared.canOpenURL(NSURL(string:"spotify:")! as URL)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width + 550)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            
            let top = UIApplication.shared.keyWindow?.safeAreaInsets.top
            return UIEdgeInsets(top: -top!, left: 0, bottom: -top!, right: 0)
            
        } else {
            // Fallback on earlier versions
            let top = -UIApplication.shared.statusBarFrame.height
            return UIEdgeInsets(top: top, left: 0, bottom: top, right: 0)
        }
    }
}
