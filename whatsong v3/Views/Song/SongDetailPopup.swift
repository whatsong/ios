//
//  SongDetailPopup.swift
//  whatsong v3
//
//  Created by Tom Andrew on 26/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit

class SongDetailPopup: UIView {
    
    var song: Song! {
        didSet  {
            songName.text = song.title
            artistName.text = song.artist.name
            timePlayed.text = "\(String(describing: song.time_play))"
            sceneDescription.text = song.scene_description
            let urlString = song.spotifyImg300
            if let urlString = urlString {
                albumImage.sd_setImage(with: URL(string: urlString))
            }            
        }
    }
    
    fileprivate func playSong()  {
        guard let url = URL(string: song.preview_url ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    func setupViews()   {
        
        setupBackgroundGradient()
        
        addSubview(dismissButton)
        addSubview(albumImage)
        addSubview(songName)
        addSubview(artistName)
        addSubview(heartIcon)
        addSubview(timeHeading)
        addSubview(timePlayed)
        addSubview(sceneHeading)
        addSubview(sceneDescription)
        addSubview(openWithHeading)
        addSubview(spotifyIcon)
        addSubview(spotifyButton)
        addSubview(youtubeIcon)
        addSubview(youtubeButton)
        
        dismissButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        
        albumImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 60, left: 0, bottom: 0, right: 0))
        albumImage.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        albumImage.constrainHeight(constant: 150)
        albumImage.constrainWidth(constant: 150)
        
        songName.anchor(top: albumImage.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 28, left: 30, bottom: 0, right: 0))
        songName.constrainWidth(constant: frame.width * 0.70)
        
        artistName.anchor(top: songName.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 30, bottom: 0, right: 0))
        artistName.constrainWidth(constant: frame.width * 0.70)

        heartIcon.anchor(top: albumImage.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 36, left: 0, bottom: 0, right: 35))
        heartIcon.constrainHeight(constant: 28)
        heartIcon.constrainWidth(constant: 31)
        
        timeHeading.anchor(top: artistName.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 30, bottom: 0, right: 0))
        
        timePlayed.anchor(top: timeHeading.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        
        sceneHeading.anchor(top: timePlayed.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 30, bottom: 0, right: 0))
        
        sceneDescription.anchor(top: sceneHeading.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        
        openWithHeading.anchor(top: sceneDescription.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 30, bottom: 0, right: 0))
        
        spotifyIcon.anchor(top: openWithHeading.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 30, bottom: 0, right: 0))
        
        spotifyButton.anchor(top: openWithHeading.bottomAnchor, leading: spotifyIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 10, bottom: 0, right: 0))
        
        youtubeIcon.anchor(top: spotifyButton.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 30, bottom: 0, right: 0))
        
        youtubeButton.anchor(top: spotifyButton.bottomAnchor, leading: youtubeIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 13, left: 10, bottom: 0, right: 0))
    }
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(dismissFunc), for: .touchUpInside)
        return button
    }()
    
    let albumImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "album-cover")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
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
        iv.image = UIImage(named: "heart-icon")
        iv.contentMode = .scaleToFill
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
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let spotifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Spotify", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(dismissFunc), for: .touchUpInside)
        return button
    }()
    
    let youtubeIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "youtube-icon")
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let youtubeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Youtube", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(dismissFunc), for: .touchUpInside)
        return button
    }()
    
    @objc func dismissFunc()  {
        
        let window: UIWindow? = UIApplication.shared.keyWindow
        let offsetY = (window?.frame.maxY)!
        print(offsetY)
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.transform = .init(translationX: 0, y: 0)
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    func setupBackgroundGradient()    {
        let layer = CAGradientLayer()
        let view = self
        layer.colors = [UIColor(red: 80/255, green: 78/255, blue: 90/255, alpha: 0.97).cgColor, UIColor.black.cgColor]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
