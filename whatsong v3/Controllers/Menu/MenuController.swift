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
    
    let textArray = [
        "Request Movie",
        "Request TV Show",
        
    ]
    
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
        
        view.addSubview(tableView)
        
        tableView.fillSuperview()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuOptionCell
        let menuOption = MenuOption(rawValue: indexPath.row)
        cell.titleLabel.attributedText = NSAttributedString(string: menuOption?.description ?? "", attributes: [
            NSAttributedString.Key.kern: -0.6
            ])
        return cell
    }
}
