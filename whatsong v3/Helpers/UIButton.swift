//
//  UIButton.swift
//  whatsong v3
//
//  Created by Tom Andrew on 9/7/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension UIButton
{
    func applyGradient(colorOne: UIColor, colorTwo: UIColor)
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradientLayer.colors =  [colorOne ,colorTwo ].map{$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
