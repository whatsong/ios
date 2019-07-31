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
        
        if cell.textLabel!.text == "Spotify" {
            cell.backgroundColor = .red
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return configureHeaderView(string: "Link Streaming Services")
        } else  {
            return configureHeaderView(string: "When did this song play?")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            return configureFooterView(string: "Link to Spotify and Youtube to allow for greater app features.")
        } else {
            return configureFooterView(string: "Add scene and time descriptions to help users easily find songs.")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func configureHeaderView(string: String) -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundGrey()
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = UIColor.brandBlack()
        let footerString = string
        label.attributedText = NSAttributedString(string: footerString, attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        
        view.addSubview(label)
        label.fillSuperview(padding: .init(top: 20, left: 16, bottom: 0, right: 16))
        
        return view
    }
    
    func configureFooterView(string: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Light", size: 13)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        let footerString = string
        label.attributedText = NSAttributedString(string: footerString, attributes: [
            NSAttributedString.Key.kern: -0.4
            ])
        
        let insets = tableView.separatorInset
        let width = tableView.bounds.width - insets.left - insets.right
        let sepFrame = CGRect(x: insets.left, y: -0.5, width: width, height: 0.5)
        let seperator = CALayer()
        seperator.frame = sepFrame
        seperator.backgroundColor = tableView.separatorColor?.cgColor
        view.layer.addSublayer(seperator)
        
        view.addSubview(label)
        label.fillSuperview(padding: .init(top: 10, left: 16, bottom: 20, right: 16))
        
        return view
    }
}

