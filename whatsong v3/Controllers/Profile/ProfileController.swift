//
//  ProfileController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 21/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ProfileController: BaseCvController, UICollectionViewDelegateFlowLayout, LibrarySongsCellDelegate   {
    
    let infoCellId = "infoCellId"
    let statsCellId = "statsCellId"
    let libraryCellId = "libraryCellId"
    var userInfo: UserInfo?
    
    var userLibrary: SongLibrary?
    var userSongs: [Song] = []
    
    let numberOfStatRows = 3
    let numberOfLibraryRows = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UserInfoCell.self, forCellWithReuseIdentifier: infoCellId)
        collectionView.register(UserStatsCell.self, forCellWithReuseIdentifier: statsCellId)
        collectionView.register(UserLibraryCell.self, forCellWithReuseIdentifier: libraryCellId)
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
        if DAKeychain.shared["accessToken"] != nil {
            setupLogOutButton()
        }
        
        Service.shared.getCurrentUserInfo { (userData, success) in
            if success {
                self.userInfo = userData?.data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } else {
                
            }
        }
        
        let urlString = "https://www.what-song.com/api/list-of-songs-favorited?username=tomm098"
        Service.shared.fetchCurrentUserSongs(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
            } else  {
                guard let userLibraryData = data else { return }
                self.userLibrary = userLibraryData
                self.userSongs = userLibraryData.data
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item ==   0    {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! UserInfoCell
            cell.userInfo = userInfo
            cell.collectionView.reloadData()
            return cell
        }   else if indexPath.item == 1   {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: statsCellId, for: indexPath) as! UserStatsCell
            cell.userStats = userInfo
            cell.collectionView.reloadData()
            return cell
        }   else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: libraryCellId, for: indexPath) as! UserLibraryCell
            cell.librarySongsCellDelgate = self
            cell.songLibrary = userLibrary
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0   {
            return CGSize(width: view.frame.width, height: 68)
        } else if indexPath.item == 1 {
            return CGSize(width: view.frame.width, height: CGFloat(numberOfStatRows * 60) + 43)
        } else {
            return CGSize(width: view.frame.width, height: CGFloat(numberOfLibraryRows * 60) + 43)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    fileprivate func setupLogOutButton()    {
        print("User logged in")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(handleLogOut))

    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            DAKeychain.shared["accessToken"] = nil
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setupLoggedOutViewControllers()
            
            self.showAlert(bgColor: UIColor.brandSuccess(), text: "You have successfully logged out")
            print("performed log out")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
        
    }
    
    func didSelectYourSongs(for songLibrary: SongLibrary) {
        let librarySongController = LibrarySongsController()
        librarySongController.userSongs = songLibrary.data
        librarySongController.navigationItem.title = "Your Songs"
        navigationController?.pushViewController(librarySongController, animated: true)
        
    }
}


