//
//  MoviesHeader.swift
//  whatsong v3
//
//  Created by Tom Andrew on 26/5/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class MoviesHeader: UICollectionReusableView    {
    
    let moviesHeaderHorizontalController = MoviesHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(moviesHeaderHorizontalController.view)
        moviesHeaderHorizontalController.view.fillSuperview()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MoviesHeaderCell: UICollectionViewCell    {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
