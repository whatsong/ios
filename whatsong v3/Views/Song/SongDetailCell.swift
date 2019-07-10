//
//  SongDetailView.swift
//  whatsong v3
//
//  Created by Tom Andrew on 11/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class SongDetailCell: UICollectionViewCell  {
    
    var song: Song! {
        didSet  {
            songName.text = song.title
            artistName.text = song.artist.name

            if song.time_play != nil    {
                guard let timeInt = song.time_play else { return }
                timePlayed.text = "\(timeInt) min"
            } else {
                timePlayed.text = "Unknown time"
                timePlayed.textColor = UIColor.brandDarkGrey()
            }
            
            if song.scene_description == nil || song.scene_description == ""    {
                sceneDescription.text = "Unknown scene"
                sceneDescription.textColor = UIColor.brandDarkGrey()
            }   else    {
                sceneDescription.text = song.scene_description
            }
            
            if song.spotify_uri == nil  {
                spotifyButton.isEnabled = true
                spotifyButton.alpha = 0.3
                spotifyIcon.alpha = 0.3
            }
            
            if song.youtube_id == nil   {
                youtubeButton.isEnabled = false
                youtubeButton.alpha = 0.3
                youtubeIcon.alpha = 0.3
            }
            
            if song.is_favorited == false   {
                heartIcon.image = UIImage(named: "heart-icon")?.withRenderingMode(.alwaysTemplate)
                print("not favorited")
            } else if song.is_favorited == true {
                heartIcon.image = UIImage(named: "heart-icon-fill")?.withRenderingMode(.alwaysTemplate)
                heartIcon.tintColor = UIColor.brandPurple()
                print("favorited")
            }
            
            let imageUrlString = song.spotifyImg640
            guard let url = imageUrlString else { return }
            
            if imageUrlString != nil {
                albumImage.sd_setImage(with: URL(string: url))
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews()   {
        
        setupBackgroundGradient()
        
        let verticalStackView = UIStackView(arrangedSubviews: [songName, artistName])
        verticalStackView.axis = .vertical
        let horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView, heartIcon])
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let spotifyStackView = UIStackView(arrangedSubviews: [spotifyIcon, spotifyButton])
        let youtubeStackView = UIStackView(arrangedSubviews: [youtubeIcon , youtubeButton])
        let timeStackView = UIStackView(arrangedSubviews: [timePlayed, editTimeButton])
        let sceneStackView = UIStackView(arrangedSubviews: [sceneDescription, editSceneIcon])
        spotifyStackView.spacing = 10; youtubeStackView.spacing = 10; timeStackView.spacing = 10; sceneStackView.spacing = 10;
        youtubeButton.constrainHeight(constant: 30)
        
        let rowStackView = UIStackView(arrangedSubviews: [
            horizontalStackView, timeHeading, timeStackView, sceneHeading, sceneStackView, openWithHeading, spotifyStackView, youtubeStackView
            ])
        rowStackView.axis = .vertical
        rowStackView.spacing = 8
        rowStackView.setCustomSpacing(30, after: horizontalStackView)
        rowStackView.setCustomSpacing(24, after: timeStackView)
        rowStackView.setCustomSpacing(24, after: sceneStackView)
        
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(albumImage)
        addSubview(playPauseButton)
        addSubview(rowStackView)
        
        albumImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        albumImage.constrainHeight(constant: frame.width)
        albumImage.constrainWidth(constant: frame.width)
        
        playPauseButton.centerXInSuperview()
        playPauseButton.anchor(top: albumImage.topAnchor, leading: nil, bottom: albumImage.bottomAnchor, trailing: nil)
    
        rowStackView.anchor(top: albumImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
        
    }
    
    
    func setPlayPauseOnAppearing()  {
        
        print(SongPlayer.shared.currentlyPlayingUrl, "currentlyPlaying")
        print(SongPlayer.shared.previewUrl, "previewUrl")
        print(song?.spotifyPreviewUrl, "spotify")
        print(song?.preview_url, "itunes")
        
        if SongPlayer.shared.doesPreviewExist(spotifyPreviewUrl: song?.spotifyPreviewUrl, iTunesPreviewUrl: song?.preview_url) == false   {
            playPauseButton.setImage(UIImage(named: "no-audio-icon-large"), for: .normal)
            playPauseButton.isEnabled = false
            playPauseButton.adjustsImageWhenDisabled = false
            print("no audio")
        } else if SongPlayer.shared.currentlyPlayingUrl == song?.spotifyPreviewUrl || SongPlayer.shared.currentlyPlayingUrl == song?.preview_url    {
            if SongPlayer.shared.player.timeControlStatus == .paused {
                playPauseButton.setImage(UIImage(named: "play-button-large"), for: .normal)
                print("paused on current song")
            } else  {
                playPauseButton.setImage(UIImage(named: "pause-button-large"), for: .normal)
                print("playing current song")
            }
        }   else    {
            playPauseButton.setImage(UIImage(named: "play-button-large"), for: .normal)
            print("different song")
        }
    }
    
    func setupBackgroundGradient()    {
        let layer = CAGradientLayer()
        let view = self
        layer.colors = [UIColor(red: 80/255, green: 78/255, blue: 90/255, alpha: 0.97).cgColor, UIColor.black.cgColor]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    
    let albumImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "album-placeholder")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-button-large"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.brandBlack()
        button.contentMode = .scaleToFill
        return button
    }()
    
    let songName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = UIColor.white
        label.text = "White Hinterland"
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor.brandLightGrey()
        label.text = "Kairos"
        return label
    }()
    
    let heartIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart-icon")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.constrainWidth(constant: 31)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let editTimeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.constrainWidth(constant: 18)
        button.constrainHeight(constant: 18)
        return button
    }()
    
    let timeHeading: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 10)
        label.textColor = UIColor.brandLightGrey()
        label.text = "HEARD IN"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timePlayed: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let editSceneIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "edit-icon")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.constrainWidth(constant: 18)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let sceneHeading: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 10)
        label.textColor = UIColor.brandLightGrey()
        label.text = "SCENE DESCRIPTION"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sceneDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.white
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openWithHeading: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 10)
        label.textColor = UIColor.brandLightGrey()
        label.text = "OPEN WITH"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let spotifyIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "spotify-icon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.constrainWidth(constant: 16)
        return iv
    }()
    
    let spotifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spotify", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let youtubeIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "youtube-icon")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.constrainWidth(constant: 16)

        return iv
    }()
    
    let youtubeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Youtube", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
