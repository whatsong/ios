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
            timePlayed.text = "\(String(describing: song.time_play))"
            sceneDescription.text = song.scene_description
            
            if song.preview_url != nil  {
                print("iTunes preview exists")
            }   else if song.preview_url == nil   {
                print("7")
                playPauseButton.setImage(UIImage(named: "no-audio-icon-large"), for: .normal)
                playPauseButton.isEnabled = false
                playPauseButton.adjustsImageWhenDisabled = false
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
        spotifyStackView.spacing = 10; youtubeStackView.spacing = 10
        youtubeButton.constrainHeight(constant: 30)
        
        let rowStackView = UIStackView(arrangedSubviews: [
            horizontalStackView, timeHeading, timePlayed, sceneHeading, sceneDescription, openWithHeading, spotifyStackView, youtubeStackView
            ])
        rowStackView.axis = .vertical
        rowStackView.spacing = 8
        rowStackView.setCustomSpacing(30, after: horizontalStackView)
        rowStackView.setCustomSpacing(24, after: timePlayed)
        rowStackView.setCustomSpacing(24, after: sceneDescription)
        rowStackView.setCustomSpacing(24, after: timePlayed)
        
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(albumImage)
        addSubview(playPauseButton)
        addSubview(rowStackView)
        addSubview(testButton)
        
        albumImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        albumImage.constrainHeight(constant: frame.width)
        albumImage.constrainWidth(constant: frame.width)
        
        playPauseButton.centerXInSuperview()
        playPauseButton.anchor(top: albumImage.topAnchor, leading: nil, bottom: albumImage.bottomAnchor, trailing: nil)
    
        rowStackView.anchor(top: albumImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
        
        testButton.anchor(top: rowStackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        testButton.constrainHeight(constant: 50)
        
    }
    
    @objc func handlePlayPause() {
        print("playpause")
    }
    
    @objc func openWithYoutube()  {
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
    
    func isSpotifyInstalled() -> Bool  {
        return UIApplication.shared.canOpenURL(NSURL(string:"spotify:")! as URL)
    }
    
    @objc func openWithSpotify()  {
        print("open with spotfiy")
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
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return button
    }()
    
    let songName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 24)
        label.textColor = UIColor.white
        label.text = "White Hinterland"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor.brandLightGrey()
        label.text = "Kairos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "heart-icon")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.constrainWidth(constant: 31)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        label.text = "17" + "minutes"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        label.text = "First song as the helicopter flies over in Mexico for a mission."
        label.numberOfLines = 0
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
        button.addTarget(self, action: #selector(openWithSpotify), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(openWithYoutube), for: .touchUpInside)
        return button
    }()
    
    let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("Test", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(testButtonHandle), for: .touchUpInside)
        return button
    }()
    
    @objc func testButtonHandle() {
        print("test button")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
