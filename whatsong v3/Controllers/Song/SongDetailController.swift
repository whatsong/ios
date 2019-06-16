//
//  SongDetailPopup1.swift
//  whatsong v3
//
//  Created by Tom Andrew on 10/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import SDWebImage

class SongDetailPopupController: BaseCvController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "songId"
    var song: Song?
    
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
        
        view.addSubview(dismissButton)
        
        dismissButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        dismissButton.constrainHeight(constant: 50)
        
    }
    
    @objc func dismissFunc()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SongDetailCell
        cell.song = song
        return cell
    }
    
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
