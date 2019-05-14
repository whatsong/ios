//
//  SongListCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 18/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import AVKit

class SongListCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource    {
    
    let cellId = "cellId"
    var songsArray: [Song] = []
    
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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        songsArray = songsArray.sorted(by: { (firstSong, secondSong) -> Bool in
            guard let timePlay0 = firstSong.time_play, let timePlay1 = secondSong.time_play else { return false }
            return timePlay0 < timePlay1
        })
        return songsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongCell
        cell.backgroundColor = .white
        let song = songsArray[indexPath.item]
        cell.songTitle.attributedText = NSAttributedString(string: song.title, attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        cell.artistName.attributedText = NSAttributedString(string: song.artist.name, attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        cell.sceneDescription.attributedText = NSAttributedString(string: song.scene_description ?? "", attributes: [
            NSAttributedString.Key.kern: -0.3
            ])

        if song.time_play == nil {
            cell.timeHeard.text = ""
            cell.minutesLabel.text = ""
        } else  {
            cell.timeHeard.text = "\(song.time_play ?? 0)"
        }
        
        let moreButtonTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreButtonTap))
        cell.moreButton.isUserInteractionEnabled = true
        cell.moreButton.addGestureRecognizer(moreButtonTapRecognizer)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showFloatingPlayer(song: self.songsArray[indexPath.row])
    }
    
    func showFloatingPlayer(song: Song) {
        guard let delegate = UIApplication.shared.delegate else { return }
        guard let window = delegate.window else { return }
        let tabBarView = window?.rootViewController as! UITabBarController
        for view in tabBarView.view.subviews {
            if view is SongFloatingPlayer {
                (view as! SongFloatingPlayer).player.replaceCurrentItem(with: nil)
                view.removeFromSuperview()
            }
        }
        let songPlayerView = SongFloatingPlayer()
        songPlayerView.song = song
        tabBarView.view.insertSubview(songPlayerView, belowSubview: tabBarView.tabBar)
        if let mainWindow = window {
            songPlayerView.anchor(top: tabBarView.tabBar.topAnchor, leading: mainWindow.leadingAnchor, bottom: nil, trailing: mainWindow.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        }
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            songPlayerView.transform = .init(translationX: 0, y: -54)
        }, completion: nil)
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
        
        let window: UIWindow? = UIApplication.shared.keyWindow
        let offsetY = (window?.frame.maxY)!

        let songDetailView = SongDetailPopup.init(frame: CGRect(x: 0, y: offsetY, width: (window?.bounds.width)!, height: (window?.bounds.height)!))
        window?.addSubview(songDetailView)
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            songDetailView.transform = .init(translationX: 0, y: -offsetY)
        }, completion: nil)
        
        let song = self.songsArray[indexPath.item]
        songDetailView.song = song
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SongCell: UICollectionViewCell    {
    
    let bg: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeHeard: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        label.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        label.text = "12"
        label.constrainWidth(constant: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let minutesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 8)
        label.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        label.text = "min"
        label.constrainWidth(constant: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let songTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        label.attributedText = NSAttributedString(string: "White Hinterland", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 15)
        label.textColor = UIColor(red: 32/255, green: 32/255, blue: 32/255, alpha: 1)
        label.attributedText = NSAttributedString(string: "Kairos", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sceneDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 14)
        label.textColor = UIColor.brandLightGrey()
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(string: "0:02 First song as the helicopter flies over somewhere in Mexico for a mission.", attributes: [
            NSAttributedString.Key.kern: -0.8
            ])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emptyScene: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 13)
        label.backgroundColor = UIColor.brandLightGrey()
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
        button.translatesAutoresizingMaskIntoConstraints = false
        button.constrainWidth(constant: 25)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let verticalTimeStackView = VerticalStackView(arrangedSubviews: [timeHeard, minutesLabel])
        verticalTimeStackView.axis = .vertical
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [songTitle, artistName, sceneDescription])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 3
        
        let stackView = UIStackView(arrangedSubviews: [verticalTimeStackView, verticalStackView, moreButton])
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)
        addSubview(divider)
        
        stackView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 18, bottom: 0, right: 18))
        divider.anchor(top: nil, leading: leadingAnchor, bottom: stackView.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        divider.constrainHeight(constant: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

