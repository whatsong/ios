//
//  SongPlayer.swift
//  whatsong v3
//
//  Created by Tom Andrew on 28/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import AVKit

extension AVPlayer {
    var isNotPlaying: Bool {
        if (self.rate != 0 && self.error == nil) {
            return false
        } else {
            return true
        }
    }
}

class SongFloatingPlayer: UIView {
    
    var song: Song! {
        didSet  {
            songName.text = song.title
            artistName.text = song.artist.name
            
            playSong()
        }
    }
    
    fileprivate func playSong()  {
        guard let url = URL(string: song.preview_url ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
        if player.isNotPlaying {
            playPauseButton.setImage(UIImage(named: "no-audio-icon"), for: .normal)
        }
    }
    
    @objc func handlePlayPause()    {
        
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause-icon"), for: .normal)
        } else  {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play-icon"), for: .normal)

        }
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    let songName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.text = "White Hinterland"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textAlignment = .center
        label.textColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart-icon")?.withRenderingMode(.alwaysTemplate)
        iv.contentMode = .scaleToFill
        iv.tintColor = .white
        iv.constrainHeight(constant: 24)
        iv.constrainWidth(constant: 26)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause-icon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleToFill
        button.constrainHeight(constant: 29)
        button.constrainWidth(constant: 29)
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return button
    }()
    
    let timeSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.maximumTrackTintColor = UIColor(red: 176/255, green: 176/255, blue: 236/255, alpha: 1)
        slider.minimumTrackTintColor = UIColor(red: 133/255, green: 133/255, blue: 215/255, alpha: 1)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    func setupViews()   {
        backgroundColor = UIColor.brandPurple()
        
        let stackView = UIStackView(arrangedSubviews: [songName, artistName])
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(heartIcon)
        addSubview(playPauseButton)
        addSubview(timeSlider)
        
        stackView.centerYInSuperview()
        stackView.anchor(top: nil, leading: heartIcon.trailingAnchor, bottom: nil, trailing: playPauseButton.leadingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        heartIcon.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        heartIcon.centerYInSuperview()
        
        playPauseButton.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        playPauseButton.centerYInSuperview()
        
        timeSlider.anchor(top: nil, leading: leadingAnchor, bottom: topAnchor, trailing: trailingAnchor)
        timeSlider.constrainHeight(constant: 2)
        
        
    }
    
    fileprivate func observePlayerCurrentTime() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { (time) in
            let totalSeconds = CMTimeGetSeconds(time)
            
            self.updateTimeSlider()
            print(totalSeconds)
        }
    }
    
    fileprivate func updateTimeSlider()    {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
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
}
