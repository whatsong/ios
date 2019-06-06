//
//  ShowsHeader.swift
//  whatsong v3
//
//  Created by Tom Andrew on 5/6/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class ShowsHeader: UICollectionReusableView {
    
    let showsHeaderHorizontalController = ShowsHeaderHorizontalController()

    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(showsHeaderHorizontalController.view)
        showsHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShowsHeaderCell: MoviesHeaderCell {
    
}
