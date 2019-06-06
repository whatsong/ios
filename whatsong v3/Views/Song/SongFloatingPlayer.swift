//
//  SongPlayer.swift
//  whatsong v3
//
//  Created by Tom Andrew on 28/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import AVKit

class SongFloatingPlayer: UIView {
    
    var song: Song! {
        didSet  {
            songName.text = song.title
            artistName.text = song.artist.name
            
//            if song.preview_url == nil {
//                print("4")
//                playPauseButton.setImage(UIImage(named: "no-audio-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
//                playPauseButton.isEnabled = false
//                playPauseButton.adjustsImageWhenDisabled = false
//                SongPlayer.shared.player.pause()
//            }   else if song.preview_url != nil {
//                print("5")
//                playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
//                playPauseButton.isEnabled = true
//            }
            if song.is_favorited == false   {
                heartIcon.setImage(UIImage(named: "heart-icon"), for: .normal)
                print("not favorited")
            } else if song.is_favorited == true {
                heartIcon.setImage(UIImage(named: "heart-icon-fill"), for: .normal)
                print("favorited")

            }
        }
    }
    
    func doesPreviewExist()   {
        // 1 -- Check if spotify preview exists. If it does, play from here.
        
        // 2 -- If it does not, check iTunes preview. If it exists, play from here.
        // - if itunesURL == "" show warning
        // - if iTunesURL does not exist
        // For iTunes, we must also check if error
    }
    
    func playSong() {
        
        let spotifyPreview = song.spotifyPreviewUrl
        let iTunesPreview = song.preview_url
        
        if spotifyPreview != nil && spotifyPreview != "0"   {
            SongPlayer.shared.playSong(song: spotifyPreview)
            print("playing from spotify")
        } else if iTunesPreview != "" && iTunesPreview != nil {
            SongPlayer.shared.playSong(song: iTunesPreview)
            print("playing from iTunes")
        } else  {
            self.showAlert(bgColor: UIColor.brandWarning(), text: "This song has no audio sample")
        }
    }
    
    @objc func handlePlayPause() {
        
         if SongPlayer.shared.player.timeControlStatus == .paused {
            SongPlayer.shared.player.play()
            playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            print("10")
        } else  {
            SongPlayer.shared.player.pause()
            playPauseButton.setImage(UIImage(named: "play-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            print("20")
        }
    }
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.constrainHeight(constant: 54)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let songName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = UIColor.brandBlack()
        label.textAlignment = .center
        label.text = "White Hinterland"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textAlignment = .center
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartIcon: UIButton    =   {
        let button = UIButton()
        button.setImage(UIImage(named: "heart-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor.brandBlack()
        button.constrainHeight(constant: 28)
        button.constrainWidth(constant: 31)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLikeSong), for: .touchUpInside)
        return button
    }()

    let viewButton:UIButton = {
        
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(showSongInfoPopup), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    @objc func showSongInfoPopup() {
        let window: UIWindow? = UIApplication.shared.keyWindow
        let offsetY = (window?.frame.maxY)!
        let songDetailView = SongDetailPopup.init(frame: CGRect(x: 0, y: offsetY, width: (window?.bounds.width)!, height: (window?.bounds.height)!))
        window?.addSubview(songDetailView)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            songDetailView.transform = .init(translationX: 0, y: -offsetY)
        }, completion: nil)
        songDetailView.song = song
        songDetailView.setPlayPauseOnAppearing()
    }
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.brandBlack()
        button.contentMode = .scaleToFill
        button.constrainHeight(constant: 29)
        button.constrainWidth(constant: 29)
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return button
    }()
    
    let timeSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.maximumTrackTintColor = UIColor.backgroundGrey()
        slider.minimumTrackTintColor = UIColor.brandBlack()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGrey()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constrainHeight(constant: 1)
        return view
    }()
    
    func setupViews()   {
        backgroundColor = UIColor.white
        
        let stackView = UIStackView(arrangedSubviews: [songName, artistName])
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        addSubview(stackView)
        addSubview(viewButton)
        addSubview(heartIcon)
        addSubview(playPauseButton)
        addSubview(timeSlider)
        addSubview(divider)
        
        view.fillSuperview()
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        viewButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        stackView.centerYInSuperview()
        stackView.anchor(top: nil, leading: heartIcon.trailingAnchor, bottom: nil, trailing: playPauseButton.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        heartIcon.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        heartIcon.centerYInSuperview()
        
        playPauseButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        playPauseButton.centerYInSuperview()
        
        timeSlider.anchor(top: nil, leading: leadingAnchor, bottom: topAnchor, trailing: trailingAnchor)
        timeSlider.constrainHeight(constant: 2)
        
        divider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    
    @objc func handleLikeSong() {
        
        if userLoggedIn() && song.is_favorited == false  {
            print("trying to like song")
            
            Service.shared.addTofavourite(songId: "\(song._id)") { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.heartIcon.setImage(UIImage(named: "heart-icon-fill"), for: .normal)
                        self.showAlert(bgColor: UIColor.brandSuccess(), text: "Successfully saved song to library")
                        self.song.is_favorited = true
                    }
                }
            }
            
        } else if userLoggedIn() && song.is_favorited == true {
            Service.shared.addTofavourite(songId: "\(song._id)") { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.heartIcon.setImage(UIImage(named: "heart-icon"), for: .normal)
                        self.showAlert(bgColor: UIColor.brandSuccess(), text: "Successfully deleted song from library")
                        self.song.is_favorited = false
                    }
                }
            }
        } else  {
            showAlert(bgColor: UIColor.brandWarning(), text: "You must be logged in to save a song")
        }
    }
    
    fileprivate func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        SongPlayer.shared.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { (time) in
            let totalSeconds = CMTimeGetSeconds(time)
            
            self.updateTimeSlider()
            print(totalSeconds)
        }
    }
    
    fileprivate func updateTimeSlider()    {
        let currentTimeSeconds = CMTimeGetSeconds(SongPlayer.shared.player.currentTime())
        let durationSeconds = CMTimeGetSeconds(SongPlayer.shared.player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        
        self.timeSlider.value = Float(percentage)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        observePlayerCurrentTime()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func tabBarContainPlayer() -> Bool {
        guard let delegate = UIApplication.shared.delegate else { return false }
        guard let window = delegate.window else { return false }
        let tabBarView = window?.rootViewController as! UITabBarController
        for view in tabBarView.view.subviews {
            if view is SongFloatingPlayer {
                return true
            }
        }
        return false
    }

    class func getCurrentPlayerFromTabBar() -> SongFloatingPlayer? {
        guard let delegate = UIApplication.shared.delegate else { return nil }
        guard let window = delegate.window else { return nil }
        let tabBarView = window?.rootViewController as! UITabBarController
        for view in tabBarView.view.subviews {
            if view is SongFloatingPlayer {
                return view as? SongFloatingPlayer
            }
        }
        return nil
    }
    
    func setPlayPauseOnAppearing() {
        
        if SongPlayer.shared.playerUrl == song.preview_url || SongPlayer.shared.playerUrl == song.spotifyPreviewUrl {
            if SongPlayer.shared.player.timeControlStatus == .paused {
                playPauseButton.setImage(UIImage(named: "no-audio-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
                print("1")
            } else  {
                playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
                print("2")
            }
        } else {
            playPauseButton.setImage(UIImage(named: "no-audio-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            print("3")
        }
    }
}
