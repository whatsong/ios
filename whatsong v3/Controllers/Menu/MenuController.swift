//
//  MenuController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 1/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var tableView: UITableView!
    let cellId = "cellId"
    var delegate: MainTabBarControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
    }
    
    func configureTableView()   {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: cellId)
        
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        
        view.addSubview(tableView)
        tableView.constrainWidth(constant: view.frame.width * 0.8)
        tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.titleLabel.attributedText = NSAttributedString(string: menuOption?.description ?? "", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        if indexPath.row == 7 {
            cell.descLabel.text = menuOption?.rightDescription
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
