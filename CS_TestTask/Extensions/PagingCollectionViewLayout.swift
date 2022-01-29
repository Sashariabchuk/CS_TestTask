//
//  PagingCollectionViewLayout.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

class PagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    var velocityThresholdPerPage: CGFloat = 10
    var numberOfItemsPerPage: CGFloat = 1
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat
        
        
        pageLength = (self.itemSize.width + self.minimumLineSpacing) * numberOfItemsPerPage
        approxPage = collectionView.contentOffset.x / pageLength
        speed = velocity.x
        
        
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: currentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: currentPage * pageLength)
            }
        }
        
        var nextPage: CGFloat = currentPage + (speed > 0 ? 1 : -1)
        
        let increment = speed / velocityThresholdPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        return CGPoint(x: nextPage * pageLength, y: 0)
    }
}
