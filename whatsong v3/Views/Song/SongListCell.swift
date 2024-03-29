//
//  SongListCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 18/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import AVKit

protocol SongCellDelegate {
    func didSelectSongDetail(for song: Song)
}

class SongListCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource    {
    
    let cellId = "cellId"
    var songsArray: [Song] = []
    var songCellDelegate: SongCellDelegate?
    
    let heading: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.attributedText = NSAttributedString(string: "List of Songs", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews()   {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SongCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        
        addSubview(heading)
        addSubview(collectionView)
        
        heading.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 18, bottom: 0, right: 0))
        
        collectionView.anchor(top: heading.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        NotificationCenter.default.addObserver(self, selector: #selector(songLiked(notification:)), name: .wsNotificationLikeSong, object: nil)
    }
    
    @objc func songLiked(notification: Notification) {
        let userInfo = notification.userInfo as! Dictionary<String,Any>
        let songId = userInfo["songId"] as! Int
        let liked = userInfo["liked"] as! Bool
        updateSong(songId: songId, liked: liked)
    }
    
    func updateSong(songId: Int, liked: Bool) {
        for (index, song) in songsArray.enumerated(){
            if songId == song._id {
                songsArray[index].is_favorited = liked
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if songsArray.count > 0 {
            
            songsArray = songsArray.sorted(by: { (firstSong, secondSong) -> Bool in
                if firstSong.time_play == nil {
                    return false
                } else if secondSong.time_play == nil {
                    return true
                } else {
                    let timePlay0 = firstSong.time_play ?? 0
                    let timePlay1 = secondSong.time_play ?? 0
                    
                    return timePlay0 < timePlay1
                }
            })
            return songsArray.count
        } else  {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongCell
        if songsArray.count == 0 {
            cell.isUserInteractionEnabled = false
            cell.artistName.isHidden = true
            cell.moreButton.isHidden = true
            cell.sceneDescription.isHidden = true
            cell.songTitle.attributedText = NSAttributedString(string: "This title has no credited songs. Please check back later.", attributes: [
                NSAttributedString.Key.kern: -0.8
                ])
            cell.songTitle.numberOfLines = 2
            cell.songTitle.textAlignment = .center
        } else {
            cell.isUserInteractionEnabled = true
            cell.backgroundColor = .white
            let song = songsArray[indexPath.item]
            cell.songTitle.attributedText = NSAttributedString(string: song.title, attributes: [
                NSAttributedString.Key.kern: -0.8
                ])
            cell.songTitle.textAlignment = .left
            cell.songTitle.numberOfLines = 1
            cell.artistName.attributedText = NSAttributedString(string: song.artist.name, attributes: [
                NSAttributedString.Key.kern: -0.6
                ])
            cell.artistName.isHidden = false
            
            cell.sceneDescription.attributedText = NSAttributedString(string: song.scene_description ?? "", attributes: [
                NSAttributedString.Key.kern: -0.3
                ])
            cell.sceneDescription.isHidden = false

            if song.time_play != nil {
                
                let mutableString = NSMutableAttributedString()
                let timeAttributes = [
                    NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 14)!,
                    NSAttributedString.Key.foregroundColor: UIColor.brandPurple(),
                    NSAttributedString.Key.kern: -0.3
                    ] as [NSAttributedString.Key : Any]
                let sceneAttributes = [
                    NSAttributedString.Key.kern: -0.3
                ] as [NSAttributedString.Key : Any]
                let time = NSAttributedString(string: "\(song.time_play ?? 0) min ", attributes: timeAttributes)
                let scene = NSAttributedString(string: song.scene_description ?? "", attributes: sceneAttributes)
                mutableString.append(time)
                mutableString.append(scene)
                
                cell.sceneDescription.attributedText = mutableString
            }
            
            let moreButtonTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreButtonTap))
            cell.moreButton.isUserInteractionEnabled = true
            cell.moreButton.addGestureRecognizer(moreButtonTapRecognizer)
            cell.moreButton.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  (indexPath.row != songsArray.count) {
            let song = songsArray[indexPath.item]
            if song.preview_url != nil || song.spotifyPreviewUrl != nil   {
                showFloatingPlayer(song: self.songsArray[indexPath.row])
            }   else    {
                self.showAlert(bgColor: UIColor.brandWarning(), text: "This song has no audio sample.")
            }
//        let song = songsArray[indexPath.item]
//        if song.preview_url != nil || song.spotifyPreviewUrl != nil   {
//            showFloatingPlayer(song: self.songsArray[indexPath.row])
//        }   else    {
//            self.showAlert(bgColor: UIColor.brandWarning(), text: "This song has no audio sample.")
        }
    }
    
    func showFloatingPlayer(song: Song, shouldPlay: Bool = true) {
        guard let delegate = UIApplication.shared.delegate else { return }
        guard let window = delegate.window else { return }
        let tabBarView = (window?.rootViewController as! MainTabBarMenuContainerController).centerTabBarController as UITabBarController
        
        // If the floating player has already been initialised
        if SongFloatingPlayer.tabBarContainPlayer() {
            let playerView = SongFloatingPlayer.getCurrentPlayerFromTabBar()
            playerView?.song = song
            if shouldPlay {
                playerView?.playSong()
            }
            return
        }
        
        // Else -- first time being initialised
        let songPlayerView = SongFloatingPlayer()
        songPlayerView.song = song
        if shouldPlay {
            songPlayerView.playSong()
        }
        
        // Adds floating player view
        tabBarView.view.insertSubview(songPlayerView, belowSubview: tabBarView.tabBar)
        if let mainWindow = window {
            songPlayerView.anchor(top: tabBarView.tabBar.topAnchor, leading: mainWindow.leadingAnchor, bottom: nil, trailing: mainWindow.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
            songPlayerView.constrainWidth(constant: frame.width)
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            songPlayerView.transform = .init(translationX: 0, y: -54)
        }, completion: nil)
        
        // Set icons on first appearing
        songPlayerView.setPlayPauseOnAppearing()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func getIndexPathFromRecognizer(gesture: UITapGestureRecognizer) -> IndexPath   {
        let tapLocation = gesture.location(in: self.collectionView)
        if let tappedIndexPath = self.collectionView.indexPathForItem(at: tapLocation)  {
            return tappedIndexPath
        }
        return IndexPath(item: 0, section: 0)
    }
    
    @objc func moreButtonTap(gesture: UITapGestureRecognizer)  {

        var indexPath = getIndexPathFromRecognizer(gesture: gesture)
        
        let songDetailView = SongDetailCell()
        let song = self.songsArray[indexPath.item]
        songDetailView.song = song
        
        print(songCellDelegate)
        if songCellDelegate != nil {
            songCellDelegate?.didSelectSongDetail(for: songsArray[indexPath.item])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SongCell: UICollectionViewCell    {
    
    let timeHeard: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = UIColor.brandPurple()
        label.constrainWidth(constant: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.text = "min"
        label.constrainWidth(constant: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor.brandBlack()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sceneDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)
        view.constrainHeight(constant: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more-button-border"), for: .normal)
        button.constrainWidth(constant: 25)
        return button
    }()
    
    func setupViews()   {
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [songTitle, artistName, sceneDescription])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 3
        
        let stackView = UIStackView(arrangedSubviews: [verticalStackView, moreButton])
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        addSubview(divider)
        
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 18, bottom: 0, right: 18))
        divider.anchor(top: nil, leading: leadingAnchor, bottom: stackView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        divider.constrainHeight(constant: 1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

