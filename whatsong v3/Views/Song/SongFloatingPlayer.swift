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
    
    var songCellDelegate: SongCellDelegate?
    var isSongEnd : Bool = false
    var song: Song! {
        didSet  {
            songName.text = song.title
            artistName.text = song.artist.name
        
            if song.is_favorited == false   {
                heartIcon.setImage(UIImage(named: "heart-icon"), for: .normal)
                print("not favorited")
            } else if song.is_favorited == true {
                heartIcon.setImage(UIImage(named: "heart-icon-fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                heartIcon.tintColor = UIColor.brandPurple()
                print("favorited")
            }
        }
    }
    
    func playSong() {
        
        func setPauseButton() {
            self.playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        if SongPlayer.shared.doesPreviewExist(spotifyPreviewUrl: song.spotifyPreviewUrl, iTunesPreviewUrl: song.preview_url)  {
            SongPlayer.shared.playSong()
            setPauseButton()
        } else  {
            self.showAlert(bgColor: UIColor.brandWarning(), text: "This song has no audio sample")
        }
    }
    
    @objc func handlePlayPause() {
        
        if SongPlayer.shared.player.timeControlStatus == .playing   {
            SongPlayer.shared.player.pause()
            playPauseButton.setImage(UIImage(named: "play-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }   else {
            SongPlayer.shared.player.play()
            playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
            if(self.isSongEnd){
                self.isSongEnd = false
                if SongPlayer.shared.doesPreviewExist(spotifyPreviewUrl: song.spotifyPreviewUrl, iTunesPreviewUrl: song.preview_url)  {
                    SongPlayer.shared.playSong()
                } else  {
                    self.showAlert(bgColor: UIColor.brandWarning(), text: "This song has no audio sample")
                }
            }
        }
    }
    
    @objc func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = .clear
        playPauseButton.isHidden = true
    }
    
    @objc func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        playPauseButton.isHidden = false
        playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
    @objc func showSongDetailView() {
        
        let songDetailController = SongDetailPopupController()
        let song = self.song
        songDetailController.song = song
        
        self.window?.rootViewController?.present(songDetailController, animated: true, completion: nil)
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
        button.addTarget(self, action: #selector(showSongDetailView), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        return button
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.brandBlack()
        button.contentMode = .scaleToFill
        button.constrainHeight(constant: 29)
        button.constrainWidth(constant: 29)
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        button.isHidden = true
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
    
    let activityIndicator: UIActivityIndicatorView = {
      
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.backgroundColor = UIColor.backgroundGrey()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        return activityIndicator
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
        addSubview(activityIndicator)
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
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = activityIndicator.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor)
        let verticalConstraint = activityIndicator.centerYAnchor.constraint(equalTo: self.playPauseButton.centerYAnchor)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
        
        timeSlider.anchor(top: nil, leading: leadingAnchor, bottom: topAnchor, trailing: trailingAnchor)
        timeSlider.constrainHeight(constant: 2)
        
        divider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        NotificationCenter.default.addObserver(self, selector: #selector(songLiked(notification:)), name: .wsNotificationLikeSong, object: nil)
    }
    
    @objc func songLiked(notification: Notification) {
        
        let userInfo = notification.userInfo as! Dictionary<String,Any>
        let liked = userInfo["liked"] as! Bool
        song.is_favorited = liked
        if liked {
            self.heartIcon.setImage(UIImage(named: "heart-icon-fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.heartIcon.tintColor = UIColor.brandPurple()
        } else {
            self.heartIcon.setImage(UIImage(named: "heart-icon"), for: .normal)
        }
    }
    
    @objc func handleLikeSong() {
        
        if userLoggedIn() && song.is_favorited == false  {
            print("trying to like song")
            //MARK: PASS TYPE
            Service.shared.addTofavourite(songId: "\(song._id)", type: "song", like: true) { (success) in
                DispatchQueue.main.async {
                    self.heartIcon.setImage(UIImage(named: "heart-icon-fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    self.heartIcon.tintColor = UIColor.brandPurple()
                    self.showAlert(bgColor: UIColor.brandSuccess(), text: "Successfully saved song to library")
                    if(self.song?.spotify_uri != nil){
                        SpotifyAPI.sharedSpotifyAPI.addSoongToPlayList(playlist_id: DAKeychain.shared["SpotifyPlaylistId"], uris: self.song?.spotify_uri, completion: { (success) in
                            print(success)
                        })
                    }
                    self.song.is_favorited = true
                    NotificationCenter.default.post(name: .wsNotificationLikeSong, object: nil, userInfo: ["liked" : true,
                                   "songId" : self.song._id])
                }
            }
        } else if userLoggedIn() && song.is_favorited == true {
             Service.shared.addTofavourite(songId: "\(song._id)", type: "song", like: false) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.heartIcon.setImage(UIImage(named: "heart-icon"), for: .normal)
                        self.showAlert(bgColor: UIColor.brandSuccess(), text: "Successfully removed song from library")
                        self.song.is_favorited = false
                        NotificationCenter.default.post(name: .wsNotificationLikeSong, object: nil, userInfo: ["liked" : false,
                                       "songId" : self.song._id])
                    }
                }
            }
        } else  {
            showAlert(bgColor: UIColor.brandWarning(), text: "You must be logged in to save a song")
        }
    }
    
    fileprivate func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        SongPlayer.shared.player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] (time) in
            //let totalSeconds = CMTimeGetSeconds(time)
            self?.updateTimeSlider()
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
        NotificationCenter.default.addObserver(self, selector: #selector(showActivityIndicator), name: .wsNotificationPlayerStartBuffer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideActivityIndicator), name: .wsNotificationPlayerFinishBuffer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(note:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
        SongPlayer.shared.player.pause()
        self.isSongEnd = true
        playPauseButton.setImage(UIImage(named: "play-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    class func tabBarContainPlayer() -> Bool {
        guard let delegate = UIApplication.shared.delegate else { return false }
        guard let window = delegate.window else { return false }
        let tabBarView = (window?.rootViewController as! MainTabBarMenuContainerController).centerTabBarController as UITabBarController
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
       let tabBarView = (window?.rootViewController as! MainTabBarMenuContainerController).centerTabBarController as UITabBarController
        for view in tabBarView.view.subviews {
            if view is SongFloatingPlayer {
                return view as? SongFloatingPlayer
            }
        }
        return nil
    }
    
    func setPlayPauseOnAppearing() {
        if SongPlayer.shared.doesPreviewExist(spotifyPreviewUrl: song.preview_url, iTunesPreviewUrl: song.spotifyPreviewUrl) == true   {
            playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
