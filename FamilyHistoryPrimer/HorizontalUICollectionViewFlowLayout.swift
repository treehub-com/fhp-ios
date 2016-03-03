//
//  HorizontalUICollectionViewFlowLayout.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class HorizontalUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if let cv = self.collectionView {
            let leftInset = cv.contentInset.left
            let itemWidth = self.itemSize.width
            let spacing = self.minimumLineSpacing
            let numberOfItems = cv.numberOfItemsInSection(0)
            let proposedOffset = proposedContentOffset.x + leftInset + itemWidth/2
            
            var targetItem = 0;
            var targetDistance = Float.infinity
            
            for i in 0...numberOfItems-1 {
                let offset = (itemWidth + spacing)*CGFloat(i) + itemWidth/2
                let distance = fabsf(Float(offset - proposedOffset))
                if distance < targetDistance {
                    targetItem = i
                    targetDistance = distance
                }
            }
            let targetX = (itemWidth + spacing)*CGFloat(targetItem) - leftInset
            
            //print("selected item: " + String(targetItem))
            //print("proposed:\(proposedContentOffset.x) - target:\(targetX)");
            return CGPoint(x: targetX, y: proposedContentOffset.y)
        }
        
        // fallback
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
    }
}
