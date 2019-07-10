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
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
