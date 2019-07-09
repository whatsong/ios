//
//  SongDetailPopup1.swift
//  whatsong v3
//
//  Created by Tom Andrew on 10/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage

protocol SongDetailPopupControllerDelegate {
    func refreshDetailScence()
}
class SongDetailPopupController: BaseCvController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "songId"
    var song: Song?
    var delegate:SongDetailPopupControllerDelegate?

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation    {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool   {
        return true
    }
    
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
        animateStatusBar()
        
        collectionView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        dismissButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        dismissButton.constrainHeight(constant: 50)
        
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer)  {
        if gesture.state == .changed {
            let translation = gesture.translation(in: self.collectionView.superview)
            self.collectionView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }   else if gesture.state == .ended {
            
            let translation = gesture.translation(in: self.collectionView.superview)
            let velocity = gesture.velocity(in: self.collectionView.superview)
            print(velocity.y)
            
            if translation.y > 180 || velocity.y > 1000 {
                self.dismissFunc()
            }   else    {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.collectionView.transform = .identity
                })
            }
        }
    }
    
    @objc func dismissFunc()  {
        self.dismiss(animated: true) {
            self.showFloatingPlayer(song: self.song!,shouldPlay: false,shouldAddToView: SongPlayer.shared.player.timeControlStatus == .paused ? false : true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongDetailCell
        cell.song = song
        cell.youtubeButton.addTarget(self, action: #selector(openWithYoutube(sender:)), for: .touchUpInside)
        cell.spotifyButton.addTarget(self, action: #selector(openWithSpotify(sender:)), for: .touchUpInside)
        cell.setPlayPauseOnAppearing()
        cell.playPauseButton.addTarget(self, action: #selector(handlePlayPause(sender:)), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(handleShare(sender:)), for: .touchUpInside)
        cell.editTimeButton.addTarget(self, action: #selector(handleEditTime), for: .touchUpInside)
        cell.editSceneIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleEditScene)))
        cell.heartIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSongLike(_:))))

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
                self.showFloatingPlayer(song: self.song!,shouldPlay: true)
            } else if SongPlayer.shared.player.timeControlStatus == .playing    {
                print("playing")
                SongPlayer.shared.player.pause()
                sender.setImage(UIImage(named: "play-button-large"), for: .normal)
            }
        }   else if SongPlayer.shared.currentlyPlayingUrl != song?.preview_url {
            sender.setImage(UIImage(named: "pause-button-large"), for: .normal)
            self.showFloatingPlayer(song: self.song!,shouldPlay: true)
            // if the Floating Player has already been initialised
            if SongFloatingPlayer.tabBarContainPlayer() {
                let currentViewPlayer = SongFloatingPlayer.getCurrentPlayerFromTabBar()
                currentViewPlayer?.song = song
                currentViewPlayer?.playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
                print("5")
                //if the Floating Player has not been initialised for the first time
            } else if SongFloatingPlayer.getCurrentPlayerFromTabBar() == nil {
                //let songListView = SongListCell()
                //songListView.showFloatingPlayer(song: song, shouldPlay: true)
                print("6")
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
                if (song.spotify_uri != nil) {
                    var str = song.spotify_uri!
                    str = str.replacingOccurrences(of: "spotify:track:", with: "", options: [.anchored], range: nil)
                    let fullString = "https://open.spotify.com/track/" + str
                    UIApplication.shared.open(URL(string: fullString)!)
                } else  {
                    print("no spotify uri")
                }
            }
        }
    }
    
    func isSpotifyInstalled() -> Bool  {
        return UIApplication.shared.canOpenURL(NSURL(string:"spotify:")! as URL)
    }
    
    @objc func handleEditScene() {
        setupFloatingView()
    }
    
    @objc func handleEditTime()  {
        print("handling edit time")
        
    }
    
    func setupFloatingView()    {
//        let dimmedBackgroundView = UIView()
//        dimmedBackgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0)
        
        if userLoggedIn()   {
            let floatingEditView = FloatingEditLauncher()
            floatingEditView.song = song
            floatingEditView.backgroundColor = .white
            floatingEditView.layer.cornerRadius = 12
            floatingEditView.layer.masksToBounds = true
            
            view.addSubview(floatingEditView)
            floatingEditView.saveTextHandel = { [weak self] text in
                Service.shared.addSceneDescription(songId: "\(self!.song!._id)", scene: text) { (success) in
                    DispatchQueue.main.async {
                        if(success){
                            
                            self!.song?.scene_description = text
                            self?.collectionView.reloadData()
                            floatingEditView.handleDismissFloatingView()
                            self?.delegate?.refreshDetailScence()
                            
                        }
                        else{
                            floatingEditView.activityIndicatorView.stopAnimating()
                        }
                    }
                }
            }
            floatingEditView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 10, bottom: -380, right: 10), size: .init(width: 0, height: 370))
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                floatingEditView.transform = .init(translationX: 0, y: -380)
                
            }, completion: nil)
        }   else    {
            showAlert(bgColor: UIColor.brandWarning(), text: "You must be logged in to edit a song")
        }
    }
    
    @objc func handleSongLike(_ sender: UITapGestureRecognizer) {
        if let senderImage = sender.view as? UIImageView{
            print("handling like")
            if userLoggedIn() && song?.is_favorited == false  {
                print("trying to like song")
                //MARK: PASS TYPE
                Service.shared.addTofavourite(songId: "\(song?._id ?? 0)", type: "song", like: true) { (success) in
                    DispatchQueue.main.async {
                        senderImage.image = UIImage(named: "heart-icon-fill")?.withRenderingMode(.alwaysTemplate)
                        senderImage.tintColor = UIColor.brandPurple()
                        
                        self.showAlert(bgColor: UIColor.brandSuccess(), text: "Successfully saved song to library")
                        self.song?.is_favorited = true
                        
                        //NotificationCenter.default.post(name: .wsNotificationLikeSong, object: nil, userInfo: ["liked" : true,
                        //"songId" : self.song._id])
                    }
                }
            } else if userLoggedIn() && song?.is_favorited == true {
                Service.shared.addTofavourite(songId: "\(song?._id ?? 0)", type: "song", like: false) { (success) in
                    if success {
                        DispatchQueue.main.async {
                            senderImage.image = UIImage(named: "heart-icon")?.withRenderingMode(.alwaysTemplate)
                            senderImage.tintColor = .white
                            self.showAlert(bgColor: UIColor.brandSuccess(), text: "Successfully removed song from library")
                            self.song?.is_favorited = false
                            //NotificationCenter.default.post(name: .wsNotificationLikeSong, object: nil, userInfo: ["liked" : false,
                            //"songId" : self.song._id])
                        }
                    }
                }
            } else  {
                showAlert(bgColor: UIColor.brandWarning(), text: "You must be logged in to save a song")
            }
        }
    }
    
    @objc func handleShare(sender: UIButton)  {
        let activityController = UIActivityViewController(activityItems: ["Hey, check out this song"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    // MARK:-- Protocol Methods
    
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
