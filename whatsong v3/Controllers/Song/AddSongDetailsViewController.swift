//
//  AddSongDetailsViewController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 22/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class AddSongDetailsViewController: UITableViewController    {
    
    let cellId = "cellId"
    
    let twoDimensionalArray = [
        ["Spotify", "Youtube"],
        ["Time", "Scene Description"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    fileprivate func setupTableView()   {
        tableView.backgroundColor = UIColor.backgroundGrey()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = twoDimensionalArray[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont(name: "Montserrat-Regular", size: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Link services"
        } else {
            return "When did this song play?"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 13)
        label.textColor = UIColor.gray

        if section == 0 {
            label.attributedText = NSAttributedString(string: "Link to Spotify and Youtube to allow for greater app features.", attributes: [
                NSAttributedString.Key.kern: -0.4
                ])
            label.numberOfLines = 2
            footerView.addSubview(label)
            label.fillSuperview(padding: .init(top: 0, left: 20, bottom: 40, right: 20))
            return footerView
        } else if section == 1  {
            label.attributedText = NSAttributedString(string: "Add scene and time descriptions to help users easily find songs.", attributes: [
                NSAttributedString.Key.kern: -0.4
                ])
            label.numberOfLines = 2
            footerView.addSubview(label)
            label.fillSuperview(padding: .init(top: 0, left: 16, bottom: 20, right: 16))
            return footerView
        }
        return footerView
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }

}

