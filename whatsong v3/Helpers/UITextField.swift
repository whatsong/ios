//
//  UITextField.swift
//  whatsong v3
//
//  Created by Tom Andrew on 27/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 124/255, green: 125/255, blue: 146/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
