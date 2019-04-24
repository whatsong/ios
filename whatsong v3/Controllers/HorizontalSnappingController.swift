//
//  HorizontalSnappingController.swift
//  whatsong v3
//
//  Created by Tom Andrew on 6/3/19.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController  {
    
    init()  {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SnappingLayout: UICollectionViewFlowLayout    {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        //let itemWidth = collectionView.frame.width * 0.75
        let itemWidth = CGFloat(120)
        let itemSpace = itemWidth + minimumInteritemSpacing
        var pageNumber = round(collectionView.contentOffset.x / itemSpace)
        
        let vX = velocity.x
        if vX > 0 {
            pageNumber += 1
        } else if vX < 0    {
            pageNumber -= 1
        }
        
        let nearestPageOffset = pageNumber * itemSpace
        return CGPoint(x: nearestPageOffset, y: parent.y)
    }
}
