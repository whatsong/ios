//
//  UIActivityViewIndicator.swift
//  whatsong v3
//
//  Created by Tom Andrew on 3/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

extension UIViewController  {
    var activityIndicatorTag: Int { return 999999 }

    func startActivityIndicator(style: UIActivityIndicatorView.Style = .gray, location: CGPoint? = nil) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: style)
            //Add the tag so we can find the view in order to remove it later
            
            activityIndicator.tag = self.activityIndicatorTag
            //Set the location
            activityIndicator.style = .gray
            activityIndicator.backgroundColor = UIColor.backgroundGrey()
            activityIndicator.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            activityIndicator.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
            activityIndicator.hidesWhenStopped = true
            //Start animating and add the view
            
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            
            if let activityIndicator = self.view.subviews.filter (
                { $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                UIApplication.shared.endIgnoringInteractionEvents()
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
