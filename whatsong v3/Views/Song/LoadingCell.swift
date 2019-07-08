//
//  LoadingCell.swift
//  whatsong v3
//
//  Created by Developer iOS on 06/07/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.color = UIColor.brandLightGrey()
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
