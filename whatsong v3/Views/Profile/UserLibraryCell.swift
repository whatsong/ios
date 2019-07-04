//
//  UserLibraryCell.swift
//  whatsong v3
//
//  Created by Tom Andrew on 27/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

protocol LibrarySongsCellDelegate {
    func didSelectYourSongs(for songLibrary: SongLibrary )
}

class UserLibraryCell: UserStatsCell    {
    
    var librarySongsCellDelgate: LibrarySongsCellDelegate?
    var songLibrary: SongLibrary?
    
    let rowsArray = ["Your Songs", "Your Playlists"]
    let libraryCellId = "libraryCellId"
    
    let libraryLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Library", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 12)
        label.textColor = UIColor.brandLightGrey()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews()   {
        
        collectionView.register(UserLibrarySingleCell.self, forCellWithReuseIdentifier: libraryCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        addSubview(libraryLabel)
        addSubview(collectionView)
        
        libraryLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        collectionView.anchor(top: libraryLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: libraryCellId, for: indexPath) as! UserLibrarySingleCell
        cell.titleLabel.attributedText = NSAttributedString(string: rowsArray[indexPath.item], attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if librarySongsCellDelgate != nil && indexPath.item == 0  {
            guard let songLibrary = songLibrary else { return }
            librarySongsCellDelgate?.didSelectYourSongs(for: songLibrary)
        }   else if indexPath.item == 1  {
            showAlert(bgColor: UIColor.brandWarning(), text: "Playlists are coming soon. Stay tuned.")
        }
        
    }
}

class UserLibrarySingleCell: UICollectionViewCell   {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "Songs Added", attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        label.textColor = UIColor.brandBlack()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView  = {
        let iv = UIImageView()
        iv.image = UIImage(named: "click-icon")
        iv.contentMode = .scaleAspectFill
        iv.constrainHeight(constant: 15)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 224/255, green: 225/255, blue: 229/255, alpha: 1)
        view.constrainHeight(constant: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews()   {
        
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(divider)
        
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        titleLabel.centerYInSuperview()
        
        imageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        imageView.centerYInSuperview()

        divider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        divider.constrainHeight(constant: 1)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
