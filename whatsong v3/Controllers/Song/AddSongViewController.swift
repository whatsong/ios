//
//  AddSongViewController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 16/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit
import Alamofire
import AVKit

class AddSongViewController: UITableViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate   {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    let cellId = "cellId"
    
    var songs: [ItunesSearchResultSong] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        
    }
    
    fileprivate func setupTableView()   {
        tableView.backgroundColor = UIColor.backgroundGrey()
        tableView.register(SearchiTunesResultCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
    fileprivate func setupSearchBar()    {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText, "entity": "song"]

        AF.request(url, method: .get, parameters: parameters, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error    {
                print("Failed to contact iTunes", err)
                return
            }
            guard let data = dataResponse.data else { return }
            do  {
                let searchResult = try JSONDecoder().decode(ItunesSearchResult.self, from: data)
                self.songs = searchResult.results
                self.tableView.reloadData()
                
            }   catch let decodeError   {
                print("Failed to decode JSON", decodeError)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SearchiTunesResultCell
        let song = songs[indexPath.item]
        cell.songTitle.text = "Song: \(song.trackName ?? "")"
        cell.artistName.text = "Artist: \(song.artistName ?? "")"
        cell.albumName.text = "Album: \(song.collectionName ?? "")"
        cell.addButton.addTarget(self, action: #selector(handleAddSong), for: .touchUpInside)
        let playButtonTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handlePlayPreview))
        cell.playPauseButton.addGestureRecognizer(playButtonTapRecognizer)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func getIndexPathFromRecognizer(gesture: UITapGestureRecognizer) -> IndexPath   {
        let tapLocation = gesture.location(in: self.tableView)
        if let tappedIndexPath = self.tableView.indexPathForRow(at: tapLocation)    {
            return tappedIndexPath
        }
        return IndexPath(item: 0, section: 0)
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        return avPlayer
    }()
    
    @objc func handlePlayPreview(gesture: UITapGestureRecognizer)  {
        var indexPath = getIndexPathFromRecognizer(gesture: gesture)
        
        let songResultCell = SearchiTunesResultCell()
        let song = self.songs[indexPath.item]
    
        guard let url = URL(string: song.previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        
        if player.timeControlStatus == .waitingToPlayAtSpecifiedRate {
            print("waiting to play")
            //songResultCell.playPauseButton.setImage(UIImage(named: "pause-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }   else if player.timeControlStatus == .playing {
            print("playing")
        }   else    {
            print("Paused")
        }
    }
    
    @objc func handleAddSong()  {
        print("handling add song")
        let vc = AddSongDetailsViewController()
        vc.title = "Add Song Details"
        navigationController?.pushViewController(vc, animated: true)
    }
}

class SearchiTunesResultCell: UITableViewCell  {
    
    var song: ItunesSearchResultSong! {
        didSet  {
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
    }
    
    func setupViews()   {
        backgroundColor = .clear

        let verticalStackView = VerticalStackView(arrangedSubviews: [songTitle, artistName, albumName])
        verticalStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [playPauseButton, verticalStackView, addButton])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 10, right: 20))
        
    }
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play-icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.brandBlack()
        button.contentMode = .scaleToFill
        button.constrainWidth(constant: 35)
        return button
    }()
    
    let songTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    let artistName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    let albumName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 14)
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("SELECT", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        button.setTitleColor(UIColor.brandPurple(), for: .normal)
        button.constrainWidth(constant: 48)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
