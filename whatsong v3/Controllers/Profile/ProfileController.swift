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
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        
        collectionView.backgroundColor = UIColor.backgroundGrey()
        
        if DAKeychain.shared["accessToken"] != nil {
            setupLogOutButton()
        }
        
        self.startActivityIndicator(center:  CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY))
        fetchUserInfo()
    }
    
    func fetchUserInfo()    {
        Service.shared.getCurrentUserInfo { [unowned self] (userData, success,error) in
            DispatchQueue.main.async {
            }
            if success {
                self.userInfo = userData?.data
                self.fetchSongs()
            } else {
                print("getCurrentUserInfo Error: \(error!.localizedDescription)")
                 DispatchQueue.main.async {
                    self.stopActivityIndicator()
                    self.showAlert(bgColor: .red, text: "Something went wrong. Please log in")
                }
            }
        }
    }
    
    func fetchSongs() {
        
        var urlString = "https://www.what-song.com/api/list-of-songs-favorited?username="
        if let userInfo = userInfo, let username = userInfo.username {
            urlString = "\(urlString)\(username)"
        }
        Service.shared.fetchCurrentUserSongs(urlString: urlString) { (data, err) in
            if let err = err {
                print(err)
                self.stopActivityIndicator()
            } else  {
                guard let userLibraryData = data else { return }
                self.userLibrary = userLibraryData
                self.userSongs = userLibraryData.data
        
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.stopActivityIndicator()
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
            
            self.showAlert(bgColor: UIColor.brandSuccess(), text: "You have successfully logged out")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = nil
            appDelegate.window?.rootViewController = MainTabBarMenuContainerController()
            appDelegate.window?.makeKeyAndVisible()
            
            print("performed log out")
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
        
    }
    
    func didSelectYourSongs(for songLibrary: SongLibrary) {
        let librarySongController = LibrarySongsController()
        librarySongController.navigationItem.title = "Your Songs"
        librarySongController.userInfo = userInfo
        navigationController?.pushViewController(librarySongController, animated: true)
    }
}


