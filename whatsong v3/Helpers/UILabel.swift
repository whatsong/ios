//
//  UILabel.swift
//  whatsong v3
//
//  Created by Tom Andrew on 6/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension UILabel   {
    convenience init(text: String, font: UIFont, color: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat)   {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton {
    convenience init(title: String, backgroundColor: UIColor)   {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
