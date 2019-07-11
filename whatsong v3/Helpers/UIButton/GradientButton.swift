//
//  GradientButton.swift
//  whatsong v3
//
//  Created by Developer iOS on 10/07/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.applyGradient(colorOne: UIColor.init(white: 0, alpha: 0), colorTwo: UIColor.init(white: 0, alpha: 0.75), colorThree: UIColor.init(white: 0, alpha: 1))
    }
}
