//
//  ProfileController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 21/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ProfileController: BaseCvController, UICollectionViewDelegateFlowLayout   {
    
    let infoCellId = "infoCellId"
    var userInfo: UserInfo?
    
    var userId: Int!    {
        didSet {
            let urlString = "https://www.what-song.com/api/me"
            Service.shared.fetchUserInfo(urlString: urlString) { (data, err) in
                
                if let err = err {
                    print(err)
                } else  {
                    
                    guard let userData = data?.data else { return }
                    self.userInfo = userData
                    print(self.userInfo)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UserInfoCell.self, forCellWithReuseIdentifier: infoCellId)
        
        collectionView.backgroundColor = .red
        
//        if Auth.auth().currentUser != nil   {
//            setupLogOutButton()
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! UserInfoCell
        cell.userInfo = userInfo
        cell.collectionView.reloadData()
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    fileprivate func setupLogOutButton()    {
        
//        guard let currentLoggedInUser = Auth.auth().currentUser?.uid else { return }
//
//        if currentLoggedInUser == userId {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(handleLogOut))
//        } else  {
//            return
//        }
    }
    
    @objc func handleLogOut() {
        
        print("handlingLogOut")
        
    }
}

class UserInfoCell: ShowInfoCell   {
    
    var userInfo: UserInfo? {
        didSet {
            fillHeaderArrayAndSubtitleArray()
        }
    }
    
    override func fillHeaderArrayAndSubtitleArray(){
        headerArray = []
        subtitleArray = []
        if let userInfo = userInfo {
            if userInfo.scores != nil {
                headerArray.append("Points")
                subtitleArray.append("\(userInfo.scores ?? 0)")
            }
            if userInfo.added_songs_count != nil {
                headerArray.append("Songs Added")
                subtitleArray.append("\(userInfo.added_songs_count ?? 0)")
            }
            if userInfo.added_scenes_count != nil {
                headerArray.append("Scenes Added")
                subtitleArray.append("\(userInfo.added_scenes_count ?? 0)")
            }
        }
        collectionView.reloadData()
    }
}
